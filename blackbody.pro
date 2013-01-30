; Homework 8.4
;
;
; Setting up the Planck blackbody spectrum
; Physical constants & units for MKS system
h = 6.626076e-34      ; Planck's constant [joule sec]
k = 1.380658e-23      ; Boltzmann's constant [joule/K]
c = 2.997925e8        ; speed of light [m/sec]
nanometer = 1e-9      ; unit definition


pro blackbody, minLambda, maxLambda, ∆L, Object_Temp

; EXAMPLE:
; Setting up x-axis: an array of 91 wavelengths from 100nm to 1000nm
; 91 because we want steps of 10 nm and (1000-100)/10=90 +1 error
; Setting up y-axis: an array of 171 values from 3000K to 20000K
; 171 because we want steps of 100K and (20000-3000)/100=170 +1 err
; gives us the general form:

nL = maxLambda-minLambda    ; Number of Lambda points
∆lambda = ∆L. * nanometer  ; Step size of lambda (x-axis)
lambda_range = nL/∆L
user_nL = (nL/∆L^2)   ; This can be swapped for lambda_range 

;
; Lambda
convert_Lambda_to_nmMin = minLambda * nanometer
convert_Lambda_to_nmMax = maxLambda * nanometer
lambda = minLambda + (convert_Lambda_to_nmMax - convert_Lambda_to_nmMin) * findgen(lambda_range)/ (lambda_range-1.)
lambda = reform(lambda,1,lambda_range,/overwrite)
lambda = rebin(lambda,Object_Temp,lambda_range)
;
; Temp
minTemp = 3000.
maxTemp = 20000.
Temp = minTemp + (maxTemp - minTemp) * findgen(nT)/(nT-1.)
Temp = reform(Temp,nT,1,/overwrite)
Temp = rebin(Temp,nT,nw)
;
; The planck function
B = 2*h*c^2 / ( lambda^5 * ( exp(h*c/(lambda*k*Temp) ) - 1 ) )
;
;
; Titles for plot
Ti = "Planck Blackbody Spectrum"
xTi = "Wavelength"
yTi = "Temperature"
zTi = "Flux"
;
shade_surf, B, lambda, Temp, charsize=2, xtitle=xTi, ytitle=yTi, ztitle=zTi, title=Ti
;
;
;
; This concludes homework 8.4


