; Joshua Sebastian
; HW 3

;pro blackbody, T, r, d, A, s, lambda

;Variables
if n_elements(T) EQ 0 then T = 5800.       ; Default temperature of Sun Kelvin [K]
;T = 3910.       ; temp of Aldebaran
if n_elements(r) EQ 0 then r = 7E8         ; Default radius of Star the size of the Sun in meters
;r = 6e8*44      ; radius of Aldebaran
;d = 65*9.4605e15; distance from Aldebaran
if n_elements(d) EQ 0 then d = 150E9       ; Default distance from Sun in meters
A = !pi*1^2     ; Area of a telescope in m^2
s = 1d          ; exposure time in seconds

; Constants and conversions
h = 6.626076e-34      ; Planck's constant [joule sec]
k = 1.380658e-23      ; Boltzmann's constant [joule/K]
c = 2.997925e8        ; speed of light [m/sec]
nanometer = 1e-9      ; unit definition
;d=d*3.24077929e-17    ; distance from parsecs to meters

; Titles for plot. EDIT them here only
title = "Joshua Sebastian's Blackbody Spectrum"
xtitle = "Wavelength [nm]"
ytitle = "Number of Photons"
;ytitle = "Intensity"
;ytitle = "Flux"
ztitle = "Temperature [K]"

; colors
color_array=fltarr(8)
color_array[0]= 238 + 130*256L + 238*65536 ; violet
color_array[1]=   0 +   0*256L + 255*65536 ; blue
color_array[2]=   0 + 255*256L +   0*65536 ; green
color_array[3]= 255 + 255*256L +   0*65536 ; yellow
color_array[4]= 255 + 165*256L +   0*65536 ; orange
color_array[5]= 255 +   0*256L +   0*65536 ; red
color_array[6]= 138 +  43*256L + 226*65536 ; blue violet for UVs
color_array[7]= 189 + 183*256L + 107*65536 ; maroon for IRs


; Playing with the variables and constants
nbins = 201.
minLambda = 100. * nanometer
maxLambda = 4000. * nanometer
lambda = minLambda + (maxLambda - minLambda) *findgen(nbins)/(nbins-1.)
dLambda = (lambda[1] - lambda[0])

temp_array = [T, T+1000., T+2000., T+3000]
d_array = [d, d+d*randomu(seed)*2, d+d*randomu(seed)/2, d+d*randomu(seed)]

; FORMULAE
; Intensity [W/m^2/sr / m(wavelength)]
B = 2*h*c^2 / ( lambda^5 * ( exp(h*c/(lambda*k*temp_array[3]) ) - 1. ) )
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
E_in_tele = F*A*s                 ; Energy of star in joules
print, total(E_in_tele)
E_of_photon = h*(c/lambda)            ; Energy of photon in joules
nphoton =  E_in_tele/E_of_photon    ; # of photons
tot_photons = total(nphoton)
print, tot_photons
print, tot_photons/n_elements(nphoton)

; plots
;plot, lambda/nanometer, B, title=title, xtitle=xtitle, ytitle=ytitle, /nodata
plot, lambda/nanometer, nphoton, title=title, xtitle=xtitle, ytitle=ytitle, /nodata

for ii = 0,3 do begin
  B = 2*h*c^2 / ( lambda^5 * ( exp(h*c/(lambda*k*temp_array[ii]) ) - 1. ) )
  ;print, B
  L = B*(4*!pi*r^2)*dLambda*!pi*(4*!pi*d_array[ii]^2)^(-1)
  ;print, L
  F = L / (4*!pi*(d_array[ii])^2)
  ;print, F
  E_in_tele = F*A*s                 ; Energy of star in joules
  ;print, total(E_in_tele)
  E_of_photon = h*(c/lambda)            ; Energy of photon in joules
  nphoton =  E_in_tele/E_of_photon
  peakB = max( B, indexOfMax )
  peakLambda = lambda[indexOfMax]
  if (temp_array[ii] LE 8500. and temp_array[ii] GT 7500.) then color=color_array[0]
  if (temp_array[ii] LE 7500. and temp_array[ii] GT 6500.) then color=color_array[1]
  if (temp_array[ii] LE 6500. and temp_array[ii] GT 5500.) then color=color_array[2]
  if (temp_array[ii] LE 5500. and temp_array[ii] GT 4500.) then color=color_array[3]
  if (temp_array[ii] LE 4500. and temp_array[ii] GT 2500.) then color=color_array[4]
  if (temp_array[ii] LE 2500. and temp_array[ii] GT 500.) then color=color_array[5]
  if (temp_array[ii] GT 8500.) then color=color_array[6]
  if (temp_array[ii] LE 500.) then color=color_array[7]
  print, "The peak wavelength for ", temp_array[ii],"K is ", peakLambda/nanometer, " nm"
  ; oplot, lambda, B, color=color
  oplot, lambda/nanometer, nphoton, color=color

endfor

image = tvrd(true=1)
image = image-255
write_PNG, "Blackbody.png", image

end
