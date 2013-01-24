; plot_circle.pro

PRO Circle, radius, xcenter, ycenter

  points = (2 * !pi / 99d) * findgen(100)
  xx = xcenter + radius * cos(points)
  yy = ycenter + radius * sin(points)
  plot, xx, yy
    
END 
