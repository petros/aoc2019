require 'minitest/autorun'

@@puzzle_input = %w{
94794
58062
112067
139512
147400
99825
142617
107263
86294
97000
140204
72573
134981
111385
88303
79387
129111
122976
130685
75100
146566
73191
107641
109940
65518
102028
57370
144556
64017
64384
145114
115853
87939
90791
133443
139050
140657
85738
133749
92466
142918
96679
125035
127629
87906
104478
105147
121741
70312
73732
60838
82292
102931
103000
135903
78678
86314
50772
115673
106179
60615
105152
76550
140591
120916
62094
111273
63542
102974
78837
94840
89126
63150
52503
108530
101458
59660
116913
66440
83306
50693
58377
62005
130663
124304
79726
63001
73380
64395
124277
69742
63465
93172
142068
120081
119872
52801
100693
79229
90365
}

@@puzzle_input.map! {|item| item.to_i }

class Day01BTest < Minitest::Test
  def test_fuel_calculation
    mdule = Mdule.new(mass: 14)
    assert mdule.calculate_fuel == 2

    mdule = Mdule.new(mass: 1969)
    assert mdule.calculate_fuel == 966

    mdule = Mdule.new(mass: 100756)
    assert mdule.calculate_fuel == 50346
  end

  def test_puzzle_answer
    sum = @@puzzle_input.inject(0){|sum, item| sum + Mdule.new(mass: item).calculate_fuel}
    assert sum == 4881041
  end
end

class Mdule
  def initialize(mass:)
    @mass = mass
  end

  def calculate_fuel
    calc_fuel(mass: @mass)
  end

  private

  def c_fuel(mass:)
    (mass / 3) - 2
  end

  def calc_fuel(mass:)
    m = c_fuel(mass: mass)
    return m if c_fuel(mass: m) < 0

    m + calc_fuel(mass: m)
  end
end
