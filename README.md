## Undergraduate Dissertation
All the child items are the raw code that was used for FFT analysis, EDM bearing life calculations and EDM circuitry simulations 
Customer FEA data has been due to redacted to NDA

# Key ideas
The EDM model was build in simulink with a simscape plug in, it produced the following data which determines the average damage depth from pitting in the customers application 

![image](https://user-images.githubusercontent.com/83457561/130152318-15669fcb-75ea-43df-a71a-573db4351cfc.png)

Which allowed the time to failure to calculated at different pre-loads

![image](https://user-images.githubusercontent.com/83457561/130152390-bc7e367b-d4bf-418a-9ddf-41edc1408e53.png)

Which suggested that higher pre load increases electrical life, due to having an increased contact patch. But will mean a decrease in mechanical life due to higher loads.

Below shows the theortical approach in derriving how a gradient function can be used to correlate electromagnetic torque and effective air gap of the motor

![image](https://user-images.githubusercontent.com/83457561/130152611-ab351412-46d5-48a8-9644-2f54244293c9.png)

Using 2D analysis to put a point of dynamic loading on the races of the bearing can emulate the effect of a pitted face in ANSYS (below)

![image](https://user-images.githubusercontent.com/83457561/130151607-44ed35d9-7965-491d-ba8e-8caba1330309.png)

Then performing FFT analysis from frequency response output ANSYS gave the key frequency peaks

![image](https://user-images.githubusercontent.com/83457561/130151552-ea43995d-2f07-4c1a-88f3-45c2ab70a65e.png)

The displacement measured from FEA was applied to different theortical effective air gaps to determine the torque variation, which the table highlights for the customers model  

![image](https://user-images.githubusercontent.com/83457561/130151506-bea547a4-68c3-4a5e-9b61-35f30bf73feb.png)

![image](https://user-images.githubusercontent.com/83457561/130151522-8d09f2ed-0feb-4d79-b09f-77d3488509cb.png)

So at maximium the customer would see a ~0.06% change in torque with pitted bearings, which is much less then typical torque ripple tolerances of ~1% with healthy bearings.
