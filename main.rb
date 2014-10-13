require_relative 'gauss_curve'
require "gnuplot"

# See sin_wave.rb first
first = []
(0...10000).each{first<<rand(400)}
second = []
(0...10000).each{second<<rand(400)+200}
first_curve = Gauss_curve.new(first,0.3);
second_curve = Gauss_curve.new(second,0.7);
Gnuplot.open do |gp|
  Gnuplot::Plot.new( gp ) do |plot|

    plot.terminal "png size 400,400"
    plot.output File.expand_path("../sin_wave.png", __FILE__)

    # see sin_wave.rb
    plot.xrange "[-5:605]"
    plot.ylabel "y"
    plot.xlabel "x"
    x = (-5..605).collect { |v| v.to_f }
    y = x.collect { |v| first_curve.get_value(v) }
    plot.data << Gnuplot::DataSet.new( [x,y] ) do |ds|
      ds.with = "lines"
      ds.linewidth = 1
    end
    x = (-5..605).collect { |v| v.to_f }
    y = x.collect { |v| second_curve.get_value(v) }
    plot.data << Gnuplot::DataSet.new( [x,y] ) do |ds|
      ds.with = "lines"
      ds.linewidth = 1
    end

  end
end
puts 'created sin_wave.gif'