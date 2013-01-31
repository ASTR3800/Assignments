; Author: Joshua Sebastian
; File: Joshua_Sebastian_HW_2.pro
; WDID: This code simply takes in the x-array, y-array, and dy-array
;       and plots y vs x as a set of diamond points. Then, from these 
;       diamond points error bars are created with a height equal to
;       the corresponding value in the dy-array. 

x=[1.,2.,3.,4.]
y = [1.,7.,3.2,9.7]
dy = [0.1,0.2,0.15,0.3]

plot, y,x,psym=4
; This is a general for loop and can be used to create error bars with other 
; arrays. The .05 is the top parts of the error bars, which isn't always 
; needed and can be commented out when appropriate. 
for ii = 0,3 do begin
  oplot, [y[ii],y[ii],y[ii]],[x[ii],x[ii]+dy[ii],x[ii]-dy[ii]],COLOR='00ff00'x
  oplot, [y[ii]+.05,y[ii]-.05],[x[ii]+dy[ii],x[ii]+dy[ii]], COLOR='00ff00'x   
  oplot, [y[ii]+.05,y[ii]-.05],[x[ii]-dy[ii],x[ii]-dy[ii]], COLOR='00ff00'x
endfor

end
