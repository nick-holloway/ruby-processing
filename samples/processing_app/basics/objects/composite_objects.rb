# Composite Objects
# 
# An object can include several other objects. Creating such composite objects 
# is a good way to use the principles of modularity and build higher levels of 
# abstraction within a program.
attr_reader :rings

def setup    
  size 640, 360
  @rings = []
  rings << EggRing.new(width*0.45, height*0.5, 0.1, 120) 
  rings << EggRing.new(width*0.65, height*0.8, 0.05, 180) 
end

def draw    
  background 0  	
  rings.each {|er| er.transmit} 
end

# vvv CLASS EGG RING

class EggRing    
  def initialize(x, y, t, sp)  		
    @ovoid = Egg.new(x, y, t, sp) 
    @circle = Ring.new
    @circle.start x, y - sp/2
  end
  
  def transmit  	    
    @ovoid.wobble
    @ovoid.display
    @circle.grow
    @circle.display
    @circle.on = true unless @circle.on
  end  	
end 

# ^^^ CLASS EGG RING

# vvv CLASS EGG

class Egg    
  attr_accessor :x, :y  # these are (or better generate) getters/setters
  # for these instance variables
  attr_accessor :tilt
  attr_accessor :angle
  attr_accessor :scalar
  
  def initialize ( x, y, t, s )  	    
    @x, @y = x, y # the @-sign means that these are instance variables
    @tilt = t
    @scalar = s / 100.0
    @angle = 0.0
  end
  
  def wobble  		
    @tilt = Math.cos( angle ) / 8
    @angle += 0.1
  end
  
  def display  	    
    no_stroke	# in Ruby-Processing classes defined inside the main sketch
    # class automatically inherit the Processing commands, just
    # like "inner classes" in Java
    fill 255  		
    push_matrix  		
    translate x, y
    rotate tilt
    scale scalar  		
    begin_shape  		    
    vertex 0, -100
    bezier_vertex 25, -100, 40, -65, 40, -40
    bezier_vertex 40, -15, 25, 0, 0, 0
    bezier_vertex -25, 0, -40, -15, -40, -40
    bezier_vertex -40, -65, -25, -100, 0, -100  		    
    end_shape        
    pop_matrix
  end    
end
  
# ^^^ CLASS EGG

# vvv CLASS RING # note width not directly available in Ring class

class Ring    
  attr_accessor :x, :y
  attr_accessor :diameter
  attr_accessor :on
  attr_accessor :max_diameter
  def start (xpos, ypos)        
    @x, @y = xpos, ypos
    @on = true
    @diameter = 1.0
    @max_diameter = $app.width * 2
  end
  
  def grow        
    @diameter += 0.5 if on
    @diameter = 0.0 if diameter > max_diameter
  end
  
  def display        
    if on
      no_fill
      stroke_weight 4
      stroke 155, 153
      ellipse x, y, diameter, diameter
    end
  end    
end

# ^^^ CLASS RING

