pro test, T
device, decompose=0

; Setting up the Planck function
h = 6.626076e-34      ; Planck's constant [joule sec]
k = 1.380658e-23      ; Boltzmann's constant [joule/K]
c = 2.997925e8        ; speed of light [m/sec]
nanometer = 1e-9      ; unit definition

N = 201.
minLambda = 100 * nanometer
maxLambda = 2500. * nanometer
lambda = minLambda + (maxLambda - minLambda) *findgen(N)/(N-1.)
temp_array = [T, T+1000., T+2000., T+3000.]
B = 2*h*c^2 / ( lambda^5 * ( exp(h*c/(lambda*k*temp_array[3]) ) - 1. ) )
plot, lambda/nanometer, B, color = 255b, title="Blackbody blah blah"

; Setting up colors for oplots
; color = red + green*256L + blue*65536
black = 0 +0*256L + 0*65536                  ; 0K to 50K 
blackish_brown = 50 + 0*256L + 0*65536      ; 50K to 125K 
brown = 100 + 0*256L + 0*65536                   ; 125K to 250K
brownish_red = 150 + 0*256L + 0*65536        ; 250K to 1000K 
red = 250 + 0*256L + 0*65536        ; 1000K to 1500K   THIS ONE DOES NOT WORK
reddish_orange = 200 + 50*256L + 0*65536     ; 1500K to 2500K
orange = 250 + 50*256L + 0*65536             ; 2500K to 3500K
orangish_yellow = 250 + 150*256L + 0*65536   ; 3500K to 4500K
yellow = 250+ 250*256L + 0*65536    ; 4500K to 5500K
yellow_green = 200 + 200*256L + 0*65536      ; 5500K to 6500K
green = 0 + 250*256L + 0*65536      ; 6500K to 7500K      NOT WORKING
greenish_blue = 100 + 200*256L + 150*65536  ; 7500K to 8500K
blue = 0 + 0*256L + 250*65536               ; 8500K to 10000K   NOT WORKING
color_array = [black, blackish_brown, brown, brownish_red, red, reddish_orange, orange, orangish_yellow, yellow, yellow_green, green, greenish_blue, blue]

for ii = 0,3 do begin
  B = 2*h*c^2 / ( lambda^5 * ( exp(h*c/(lambda*k*temp_array[ii]) ) - 1. ) )
  peakB = max( B, indexOfMax )
  peakLambda = lambda[indexOfMax]
  print, "The peak wavelength for ", temp_array[ii],"K is ", peakLambda/nanometer, " nm"
  if (temp_array[ii] ge 8500) then color=color_array[12] else $                                 ; color = blue
  if (temp_array[ii] lt 7500 and temp_array[ii] ge 6500) then bodycolor=color_array[11] else $  ; color = greenish-blue
  if (temp_array[ii] lt 6500 and temp_array[ii] ge 5500) then bodycolor=color_array[10] else $ ; color = green
  if (temp_array[ii] lt 5500 and temp_array[ii] ge 4500) then bodycolor=color_array[9] else $  ; color = yellow-green
  if (temp_array[ii] lt 4500 and temp_array[ii] ge 3500) then bodycolor=color_array[8] else $  ; color = yellow
  if (temp_array[ii] lt 3500 and temp_array[ii] ge 2500) then bodycolor=color_array[7] else $  ; color = orangish-yellow
  if (temp_array[ii] lt 2500 and temp_array[ii] ge 1500) then bodycolor=color_array[6] else $  ; color = orange
  if (temp_array[ii] lt 1500 and temp_array[ii] ge 1000) then bodycolor=color_array[5] else $  ; color = reddish-orange
  if (temp_array[ii] lt 1000 and temp_array[ii] ge 500) then bodycolor=color_array[4] else $   ; color = red
  if (temp_array[ii] lt 500 and temp_array[ii] ge 250) then bodycolor=color_array[3] else $    ; color = brownish-red
  if (temp_array[ii] lt 250 and temp_array[ii] ge 125) then bodycolor=color_array[2] else $    ; color = brown
  if (temp_array[ii] lt 125 and temp_array[ii] ge 50) then bodycolor=color_array[1] else $     ; color = blackish-brown
  if (temp_array[ii] lt 50 and temp_array[ii] ge 0) then bodycolor=color_array[0]        ; color = black
  oplot, lambda/nanometer, B, color=255b
endfor

end
