
class Gauss_curve
  def initialize(points, posibility)
    sum = 0
    points.each{|element| sum+= element}
    @expectation =  sum/points.size.to_f
    p @expectation
    points.each{|element| sum+= (@expectation-element)**2 }
    @sigma = Math.sqrt(sum/points.size)
    p @sigma
    @posibility = posibility
  end
  def get_value(x)
    Math.exp(-0.5*((x-@expectation)/@sigma)**2)/(@sigma*Math.sqrt(2*Math::PI))*@posibility
  end
end