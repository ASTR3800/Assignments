; Joshua Sebastian
; HW 3 - 5

;pro blackbody, T, r, d, A, s, nbins
;
; Constants and conversions
h = 6.626076d-34      ; Planck's constant [joule sec]
k = 1.380658d-23      ; Boltzmann's constant [joule/K]
c = 2.997925d8        ; speed of light [m/sec]
nanometer = 1d-9      ; unit definition [nm]
AU = 149.6E9          ; distance to Sun from Earth in [m]
ly = 9.4605284d15     ; meters in 1 ly
parsec = 3.0856775814671900d16  ; meters in 1 [pc]
rSun = 6.96342d8      ; radius of Sun [m]
mSun = 1.9891d30      ; mass of Sun [kg]
LSun = 3.846d26       ; luminosity of Sun [W]

; INPUTS
;T = 3910.         ; temp of Aldebaran
;r = 6e8*44        ; radius of Aldebaran
;r = 1.7*rSun      ; radius of Sirius A is 1.7*rSun
d = 10*parsec     ; 10 parsecs
;d = 8.6*ly        ; distance to Sirius A
A = !pi*1.2^2     ; Area of a telescope in m^2. HST has a radius of 1.2 m
;A = !pi*.00125    ; Area of eye in m^2. Eye has a radius of 1.25 cm
s = 1000.            ; exposure time in seconds
nbins = 1001

; DEFAULTS
if n_elements(T) EQ 0 then T = 5800.       ; Default temperature of Sun Kelvin [K]
if n_elements(r) EQ 0 then r = 6.96342d8   ; Default radius of Star the size of the Sun in meters [m]
if n_elements(d) EQ 0 then d = 149.6E9     ; distance from Sun in meters [m]
if n_elements(A) EQ 0 then A = 1.25e-2     ; Radius, in meters, of the average human eye
if n_elements(s) EQ 0 then s = 1.          ; 1 second 
if n_elements(nbins) EQ 0 then nbins = 1001; number of bins
; Playing with the variables and constants
; **NOTE** the minLambda and maxLambda may have to be adjusted to obtain correct values. 
nbins = nbins                   ; number of bins
minLambda = 100. * nanometer    ; lowest lambda to be plotted
maxLambda = 10000. * nanometer   ; highest lambda to be plotted
lambda = minLambda + (maxLambda - minLambda) *findgen(nbins)/(nbins-1.)
dLambda = (lambda[1] - lambda[0])

; FORMULAE
; Spectral Radiance [W/m^2/sr / m(wavelength)]
B = 2*h*c^2 / ( lambda^5 * ( exp(h*c/(lambda*k*T) ) - 1. ) )
;print, B
; Luminosity [W]
L = B*(4*!pi*r^2)*dLambda*!pi
;print, L
; Flux [Js^-1/m^2] or [W/m^2]
F = L/(4*!pi*d^2)
; Peak Lambda
peakB = max( B, indexOfMax )
peakLambda = lambda[indexOfMax]

; Expected Count of photons [#]
E_gathered = F*A*s                 ; Energy of star in joules
E_of_photon = h*(c/lambda)            ; Energy of photon in joules
nphoton =  E_gathered/E_of_photon    ; # of photons
tot_photons = total(nphoton)        ; sum total of all photons from source
photons_gathered = (tot_photons*.8)*.3  ; photons gathered on telescope


; Titles for plot. EDIT them here only
title = "# of photons gathered from star 10 parsecs away"
xtitle = "Wavelength [nm]"
ytitle = "Number of Photons"
;ytitle = "Intensity"
;ytitle = "Flux"
ztitle = "Temperature [K]"

; color table
color_array=fltarr(8)
violet = 238+130*256L+238*65536 ; for UVs
color_array[0]= violet
blue_violet= 138+43*256L+226*65536 ; 
color_array[6]= blue_violet
blue =0+0*256L+255*65536 ; 
color_array[1]= blue
green =   0+255*256L+0*65536 ; 
color_array[2]= green
yellow = 255+255*256L+0*65536 ; 
color_array[3]= yellow
orange = 255+165*256L+0*65536 ; 
color_array[4]= orange
red= 255+0*256L+0*65536 ; 
color_array[5]= red
maroon = 189+183*256L+107*65536 ; for IRs
color_array[7]= maroon

; plots -- switch between these
;plot, lambda/nanometer, B, title=title, xtitle=xtitle, ytitle=ytitle, /nodata
plot, lambda/nanometer, nphoton, title=title, xtitle=xtitle, ytitle=ytitle, /nodata

; print statements of possibly useful information. comment in/out as needed
print, "A star with temperature ", T, " K , distance ", d/parsec, " parsecs, and radius ", r, " meters tells us the following:"
print, ""
print, "The peak wavelength for a star of temperature ", T," K is ", peakLambda/nanometer, " nm" 
print, "Total number of photons gathered by HST over ", s, " seconds is", photons_gathered
;print, "Total Spectral Radiance is ", total(B)
print, "The total Luminosity of this star is ", total(L), " which is ", total(L)/LSun, " times that of the Sun."
print, ""
print, ""
; This for loop takes the temp and distance arrays and creates plots using randomly generated
; temperatures and distances. This could simply be converted to arrays that contain actual
; data on stars. I think that this would have to be done in the form Sirius.temp or Sirius.dist
temp_array = [T, T+T*randomu(seed), T-T*randomu(seed)]
d_array = [d, d+d*randomu(seed), d-d*randomu(seed)]

for ii = 0,2 do begin
  B_array = 2*h*c^2 / ( lambda^5 * ( exp(h*c/(lambda*k*temp_array[ii]) ) - 1. ) )
  L_array = B_array*(4*!pi*r^2)*dLambda*!pi
  F_array = L_array / (4*!pi*(d_array[ii])^2)
  E_gathered = F_array*A*s                 ; Energy of star in joules
  E_of_photon = h*(c/lambda)            ; Energy of photon in joules
  nphoton =  E_gathered/E_of_photon
  tot_photons = total(nphoton)
  photons_gathered = (tot_photons*.8)*.3  ; photons gathered on telescope
  peakB = max( B_array, indexOfMax )
  peakLambda = lambda[indexOfMax]
  if (temp_array[ii] GT 8500.) then begin
    color=violet
    type='violet'    ; Ultra High temp for surface of star
    endif
  if (temp_array[ii] LE 8500. and temp_array[ii] GT 7500.) then begin
    color=blue_violet
    type='blue_violet'
    endif
  if (temp_array[ii] LE 7500. and temp_array[ii] GT 6500.) then begin
    color=blue
    type='blue'
    endif
  if (temp_array[ii] LE 6500. and temp_array[ii] GT 5500.) then begin 
    color=green 
    type='green'  ; Sun falls in this range
    endif
  if (temp_array[ii] LE 5500. and temp_array[ii] GT 4500.) then begin
    color=yellow
    type='yellow'
    endif
  if (temp_array[ii] LE 4500. and temp_array[ii] GT 2500.) then begin 
    color=orange
    type='orange'
    endif
  if (temp_array[ii] LE 2500. and temp_array[ii] GT 500.) then begin
    color=red
    type='red'
    endif
  if (temp_array[ii] LE 500.) then begin
    color=maroon
    type='maroon'     ; Low temps would emit in infrared
    endif
  
  ;print, "The peak wavelength for a star with temperature ", temp_array[ii]," K is ", peakLambda/nanometer, " nm", " 
  print, "After ", s, " seconds of exposure, HST gathered ", photons_gathered, " photons from the ", type, " star, which is ", d_array[ii]/parsec, " parsecs away."
  print, "The Luminosity of this star is ", total(L_array), " Watts, which is ", total(L_array)/LSun, " times that of the Sun." 
  print, ""
  ;oplot, lambda/nanometer, B_array, color=color
  oplot, lambda/nanometer, nphoton, color=color
  xyouts, max(lambda, indexofmax), max(nphoton), "'Star'+([ii]+1)"

endfor

; Uncomment the lines below to produce an output image of the plot window in a transferable file format.
;image = tvrd(true=1)
;image = image-255
;write_png, "Blackbody.png", image

end
