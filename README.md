# A modification of Newton's method for nondifferentiable equations

"A modification of Newton's method for nondifferentiable equations" is an implementation of the techniques presented in
[A modification of Newton's method for nondifferentiable equations](https://doi.org/10.1016/S0377-0427(03)00650-2)

## Build Instructions

### Requirements
Instructions were tested using Docker version 18.06.0-ce, build 0ffa825, on Ubuntu 16.04.5 LTS.

### Building with Docker
    docker build -t ${DOCKER_IMAGE_NAME} .

## Run Instructions

### Running with Docker
To start a container for the Docker image:

    docker run -it --rm -v $(pwd):/Scratch ${DOCKER_IMAGE_NAME}

#### Run Everything
Within the Docker container, to run everything, computational scripts for
experiments and visualization scripts, run

    ./run.sh

Please be aware of computational efforts for the scripts. More details can be found [here](COMPUTATIONAL_EFFORTS.md).

See sections below provide for details about the individual steps.

#### Running Computational Scripts
Within the Docker container, run

    ./computation.sh

Output will be `computed_results.txt`.

Expected results is `expected_results.txt'.

## Reproduction Notes
We kept track of our progress and issues inside `notes.txt`. We also have an
jupyter notebook showing this progress over time `ReproducibilityPlot.ipynb`.

## Acknowledgements
We want acknowledge the authors for their fine work on this experiment. We
succeeded with this project where many others had failed. The authors should be
commended on putting together high quality work.
