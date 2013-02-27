; Joshua Sebastian
; HW 6

openr, unit, 'rays.dat', /get_lun
nrows = file_lines('rays.dat')
x = fltarr(nrows)
y = fltarr(nrows)
z = fltarr(nrows)
qx= fltarr(nrows)
qy= fltarr(nrows)
qz= fltarr(nrows)

; GATHERING THE DATA
for ii = 0, nrows-1 do begin
  readf, unit, xt, yt, zt, qxt, qyt, qzt
  x[ii] = xt
  y[ii] = yt
  z[ii] = zt
  qx[ii]= qxt
  qy[ii]= qyt
  qz[ii]= qzt
endfor  

close, unit
free_lun, unit

; MAKING A TABLE
openw, table, 'rays_av.txt', /get_lun
printf, table, x[0:24], y[0:24]
close, table
free_lun, table
meanx=mean(x)
meany=mean(y)
difx=x-meanx
dify=y-meany
plot, difx, dify, title='Yay rays!', psym=3
image = tvrd(true=1)
image = image-255
write_png, "rays.png", image
end

