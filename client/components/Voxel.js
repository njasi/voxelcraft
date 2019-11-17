import React, { Component } from "react";
import { connect } from "react-redux";
import * as THREE from "three";
import Info from "./Info";
const OrbitControls = require("three-orbit-controls")(THREE);

function distanceFromOrigin(v) {
  return Math.sqrt(v.x * v.x + v.y * v.y + v.z * v.z);
}

class Voxel extends Component {
  constructor() {
    super();
    this.onDocumentMouseMove = this.onDocumentMouseMove.bind(this);
    this.onDocumentMouseDown = this.onDocumentMouseDown.bind(this);
    this.onWindowResize = this.onWindowResize.bind(this);
    this.renderThree = this.renderThree.bind(this);
    this.init = this.init.bind(this);
    this.onWindowResize = this.onWindowResize.bind(this);
    this.animate = this.animate.bind(this);

    this.blockSize = 16;
    this.cameraSpeed = 5;
    this.zoomLimit = 800;

    this.camera;
    this.controls;
    this.scene;
    this.renderer;
    this.plane;
    this.mouse;
    this.raycaster;
    this.keys = {
      shift: false,
      w: false,
      a: false,
      s: false,
      d: false,
      space: false
    };
    this.rollOverMesh;
    this.rollOverMaterial;
    this.cubeGeo;
    this.cubeMaterial;
    this.objects = [];
  }

  renderThree() {
    this.renderer.render(this.scene, this.camera);
  }

  onWindowResize() {
    this.camera.aspect = window.innerWidth / window.innerHeight;
    this.camera.updateProjectionMatrix();
    this.renderer.setSize(window.innerWidth, window.innerHeight);
  }

  onDocumentMouseMove(event) {
    // event.preventDefault();
    this.mouse.set(
      (event.clientX / window.innerWidth) * 2 - 1,
      -(event.clientY / window.innerHeight) * 2 + 1
    );
    this.raycaster.setFromCamera(this.mouse, this.camera);
    let intersects = this.raycaster.intersectObjects(this.objects);
    if (intersects.length > 0) {
      let intersect = intersects[0];
      this.rollOverMesh.position
        .copy(intersect.point)
        .add(intersect.face.normal);
      this.rollOverMesh.position
        .divideScalar(this.blockSize)
        .floor()
        .multiplyScalar(this.blockSize)
        .addScalar(this.blockSize / 2);
    }
    // this.renderThree();
  }

  onDocumentMouseDown(event) {
    console.log(event.target)
    // event.preventDefault();

    if (event.ctrlKey) {
      this.camera.rotation.y += 0.1;
    }

    this.mouse.set(
      (event.clientX / window.innerWidth) * 2 - 1,
      -(event.clientY / window.innerHeight) * 2 + 1
    );
    this.raycaster.setFromCamera(this.mouse, this.camera);
    let intersects = this.raycaster.intersectObjects(this.objects);
    if (intersects.length > 0) {
      console.log(event);
      let intersect = intersects[0];
      switch (event.which) {
        case 1: {
          // left
          if (intersect.object !== this.plane) {
            this.scene.remove(intersect.object);
            console.log(intersect.object.position);
            this.objects.splice(this.objects.indexOf(intersect.object), 1);
          }
          break;
        }
        case 3: {
          // right
          let voxel = new THREE.Mesh(this.cubeGeo, this.cubeMaterial);
          console.log(voxel.position);
          voxel.position.copy(intersect.point).add(intersect.face.normal);
          voxel.position
            .divideScalar(this.blockSize)
            .floor()
            .multiplyScalar(this.blockSize)
            .addScalar(this.blockSize / 2);
          console.log(voxel.position);
          this.scene.add(voxel);
          this.objects.push(voxel);
          break;
        }
      }
    }
  }

  animate() {
    requestAnimationFrame(this.animate, this.renderer.domElement);
    this.renderThree();

    let direction = new THREE.Vector3();
    this.camera.getWorldDirection(direction);
    const { x, y, z } = this.camera.position;

    if (distanceFromOrigin(this.camera.position) > this.zoomLimit) {
      this.camera.position.set(x, y, z);
    }
  }

  init() {
    this.renderer = new THREE.WebGLRenderer({ antialias: true });
    this.renderer.setPixelRatio(window.devicePixelRatio);
    this.renderer.setSize(window.innerWidth, window.innerHeight);

    this.camera = new THREE.PerspectiveCamera(
      45,
      window.innerWidth / window.innerHeight,
      1,
      10000
    );
    this.camera.position.set(
      this.blockSize * 18,
      this.blockSize * 18,
      this.blockSize * 18
    );
    this.camera.lookAt(0, 0, 0);

    this.controls = new OrbitControls(this.camera, this.renderer.domElement);
    this.controls.target.set(0, 0, 0);
    this.controls.update();

    this.scene = new THREE.Scene();
    const loader = new THREE.CubeTextureLoader();
    const skybox = loader.load([
      "/minecraft/textures/skybox/back.png",
      "/minecraft/textures/skybox/front.png",
      "/minecraft/textures/skybox/up.png",
      "/minecraft/textures/skybox/down.png",
      "/minecraft/textures/skybox/left.png",
      "/minecraft/textures/skybox/right.png"
    ]);
    this.scene.background = skybox;
    // roll-over helpers
    let rollOverGeo = new THREE.BoxBufferGeometry(
      this.blockSize,
      this.blockSize,
      this.blockSize
    );
    this.rollOverMaterial = new THREE.MeshBasicMaterial({
      color: 0xfd0000,
      opacity: 0.5,
      transparent: true
    });
    this.rollOverMesh = new THREE.Mesh(rollOverGeo, this.rollOverMaterial);
    this.scene.add(this.rollOverMesh);

    // cubes
    this.cubeGeo = new THREE.BoxBufferGeometry(
      this.blockSize,
      this.blockSize,
      this.blockSize
    );

    let texture = new THREE.TextureLoader().load(
      "/minecraft/textures/block/stone.png"
    );
    texture.anisotropy = this.renderer.getMaxAnisotropy();
    this.cubeMaterial = new THREE.MeshLambertMaterial({
      map: texture
    });

    // grid
    let gridHelper = new THREE.GridHelper(this.blockSize * 20, 20);
    this.scene.add(gridHelper);

    //
    this.raycaster = new THREE.Raycaster();
    this.mouse = new THREE.Vector2();
    let geometry = new THREE.PlaneBufferGeometry(
      this.blockSize * 20,
      this.blockSize * 20
    );
    geometry.rotateX(-Math.PI / 2);
    this.plane = new THREE.Mesh(
      geometry,
      new THREE.MeshBasicMaterial({ visible: false })
    );
    this.scene.add(this.plane);
    this.objects.push(this.plane);
    // lights
    let ambientLight = new THREE.AmbientLight(0x606060);
    this.scene.add(ambientLight);
    let directionalLight = new THREE.DirectionalLight(0xffffff);
    directionalLight.position.set(1, 0.75, 0.5).normalize();
    this.scene.add(directionalLight);
    document.body.appendChild(this.renderer.domElement);

    document.addEventListener("mousemove", this.onDocumentMouseMove, false);
    document.addEventListener("mousedown", this.onDocumentMouseDown, false);
    document.addEventListener("contextmenu", event => event.preventDefault());
    window.addEventListener("resize", this.onWindowResize, false);
  }

  componentDidMount() {
    this.init();
    // this.renderThree();
    this.animate();
  }

  render() {
    return (
      <React.Fragment>
        <div ref={ref => (this.mount = ref)} />
      </React.Fragment>
    );
  }
}

const mapProps = state => {
  return {
    // blocks:state.blocks
  };
};

const mapDispatch = dispatch => {
  return {
    //   load : ()=>dispatch(fetchBlocks()),
    //   setBlock : (block) => dispatch(setBlock(block)),
    //   removeBlock : (pos) => dispatch(setBlock({...pos,type:"air"}))
  };
};

export default connect(mapProps, mapDispatch)(Voxel);
