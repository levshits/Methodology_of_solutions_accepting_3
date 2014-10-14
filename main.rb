require_relative 'gauss_curve'
require 'tk'
require 'gruff'

# See sin_wave.rb first
def create_source_array(max, shift)
  result = []
  (0...50000).each{result<<rand(max)+shift}
  return result
end
def create_pict(curves)
  g = Gruff::Line.new
  g.title = 'Wow!  Look at this!'
  curves.each_index{|index| g.data "Set ##{index+1}",curves[index]}
  g.write('exciting.png')
end
def calculate_lines(curves, absolute_max)
  result = []
  x = (0..1000).collect { |v| v =(v.to_f/1000*absolute_max) }
  curves.each{|element|
    result<< x.collect { |v| element.get_value(v) }
    }
  return result
end
def calculate_error(lines_data, absolute_max)
  error_of_finding = 0
  false_nervous = 0
  x = 0
  (0...1000).each{|index|
  if lines_data[0][index]>lines_data[1][index]
    false_nervous+=lines_data[1][index]
  else
    if x ==0
      x = index
    end
    error_of_finding+=lines_data[0][index]
  end}
  error_of_finding*=absolute_max.to_f/1000
  false_nervous*=absolute_max.to_f/1000
  x = (x*absolute_max.to_f/1000).to_i
  return [error_of_finding,false_nervous,x]
end
first = create_source_array(100,0)
second = create_source_array(100,50)
first_curve = Gauss_curve.new(first,0.5);
second_curve = Gauss_curve.new(second,0.5);
lines_data = calculate_lines([first_curve,second_curve], 150)
error = calculate_error(lines_data,150)
p error
create_pict(lines_data)