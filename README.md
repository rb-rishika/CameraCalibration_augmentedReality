# CameraCalibration_augmentedReality

**Part I**: Camera Calibration using 3D calibration object (50 points) We want to calibrate the camera of a robot vehicle. We will use a linear method as described in the lectures. We place a large cubic frame of size 4 meters on the road several meters in front of the vehicle. The positions of the eight corners of the cubic frame are defined with respect to a world coordinate system with its axes parallel to the cube edges and with its origin at the center of the cube. The world coordinates of the cube vertices are:
2 2 2,
-2 2 2,
-2 2 -2,
2 2 -2,
2 -2 2,
-2 -2 2,
-2 -2 -2,
2 -2 -2
We detect the corresponding cube corners at the following pixel positions in the camera image: 422 323; 178 323; 118 483; 482 483; 438 73; 162 73; 78 117; 522 117

**Part II**: Camera Calibration using 2D calibration object (70 points) In this part we are going to implement camera calibration from multiple images of 2D planes. Additionally we will learn how to augment images with virtual objects. We will follow the method described in the book chapter on camera calibration by Zhengyou Zhang which was proposed in his paper “Flexible Camera Calibration by Viewing a Plane from Unknown Orientations - Zhang, ICCV99”. Start by carefully reading Section 2.4 of that Chapter. Calibration Grid and images We know the following about the grid. The grid is 9 squares in width and 7 in height. Each square is 30mm x 30mm. If we select the bottom left corner of the grid to be the origin of the world coordinate system, and the grid to be the plane corresponding to Z=0 , then we know the 3D coordinates of each corner in that grid. For calibration we will use four images: images2.png, images9.png, images12.png, images20.png

**Part III**: Augmented Reality 101 (50 points) Augmenting an Image (30 points) Now we would like to use our computed homographies from part II to map a clip art image onto the grid such that it seems to be part of the grid. The image should be synthesized such that the clip art bottom left corners is the same as the grids (0,0) corner. When fitting the clip art you should rescale it to fit the grid while keeping the clip art aspect ratio. Using your computed homography find a way to map your image on the grid such that you image will have the same projective distortion as the grid. If the clip art have any white pixels you should make these pixels appears transparent when overlayed over the grid. For each image of the four images in Part II, create a figure with the original image and your virtual clip art overlayed over the grid. Your image should be one of the images provided in the clipart directory. To find which clip art you are supposed to map, take the last 4 digits of your ruid id add them up and use the clip art file corresponding to the first digit in the sum, i.e., if the first 4 digits in your RUID are 5243, use the clip art 4.xxx . Augmenting an Object (20 points) Now we would like to augment our images with 3D objects. For our purposes we are going to use a cube as a virtual object. We will only render the cube as a wire frame and we would like its base to be locate on the 3x3 grid of squares in the bottom left corner of our grid. The cube should be standing up from the grid. First print the 3D coordinates of the cube. Then, find a way to use your computed H, K, R, t to synthesize new images with the virtual cube inserted
