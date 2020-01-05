# photon recycling
This repository contains the MATLAB codes and the presentations of my research that I conducted in my sophomore year under the
supervision of Asst. Prof. Selcuk Yerci.

We have tried to numerically model and simulate "Photon Recycling" in solar cells. The process of re-absorbing a photon emitted
by the radiative recombination is called as "Photon Recycling". 

You can see the detailed formulization of the Photon Recycling Phenomenon in presentations. The modelling is the 
reproduction of the Balenzategui and Marti's work. You can find the paper under the name of "Detailed modelling of
photon recycling: application to GaAs solar cells".

The algorithm of the simulation is as follows:

- The solar cell structure is simulated with SCAPS without 𝐺_𝑃𝑅term and the quasi-Fermi level separation is given as input to MATLAB.
- MATLAB code generates an initial photon recycling generation rate profile and gives the profile to SCAPS.
- This quasi-Fermi level separation and generation profile exchange continues until the quasi-Fermi level separation converges to some point.
- SCAPS simulates the structure with additional photon recycling generation profile and new quasi-Fermi level separation is given again to MATLAB.
- After the convergence, simulation results taken into consideration photon recycling is obtained.

Here, you see my reproduced simulation results and the original simulation results in the Balenzategui's paper:

![My Reproduced Simulation Results](https://github.com/refik-mert-cam/photon_recycling/blob/master/my_reproduction.PNG)
![Original Simulation Results in Balenzategui's Paper](https://github.com/refik-mert-cam/photon_recycling/blob/master/photonrecycling.PNG)
