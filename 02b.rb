require 'minitest/autorun'

class Day02BTest < Minitest::Test
  EXPECTED_OUTPUT = 19690720
  PUZZLE_INPUT =
    [1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,9,19,1,19,5,23,2,6,23,27,1,6,27,
     31,2,31,9,35,1,35,6,39,1,10,39,43,2,9,43,47,1,5,47,51,2,51,6,55,1,5,
     55,59,2,13,59,63,1,63,5,67,2,67,13,71,1,71,9,75,1,75,6,79,2,79,6,83,
     1,83,5,87,2,87,9,91,2,9,91,95,1,5,95,99,2,99,13,103,1,103,5,107,1,2,
     107,111,1,111,5,0,99,2,14,0,0]

  def test_computer
    computer = Computer.new
    program = Program.new([1, 0, 0, 0, 99])
    computer.load(program)
    computer.run
    assert_equal [2, 0, 0, 0, 99], computer.memory

    computer = Computer.new
    program = Program.new([2, 3, 0, 3, 99])
    computer.load(program)
    computer.run
    assert_equal [2, 3, 0, 6, 99], computer.memory

    computer = Computer.new
    program = Program.new([2, 4, 4, 5, 99, 0])
    computer.load(program)
    computer.run
    assert_equal [2, 4, 4, 5, 99, 9801], computer.memory

    computer = Computer.new
    program = Program.new([1, 1, 1, 4, 99, 5, 6, 0, 99])
    computer.load(program)
    computer.run
    assert_equal [30, 1, 1, 4, 2, 5, 6, 0, 99], computer.memory
  end

  def test_puzzle_answer
    computer = Computer.new
    program = Program.new(PUZZLE_INPUT)
    (0..99).each do |va|
      (0..99).each do |vb|
        computer.load(program, va, vb)
        computer.run
        if computer.output == EXPECTED_OUTPUT
          # puts "The pair that produces #{EXPECTED_OUTPUT} is #{va}, #{vb}"
          break
        end
      end
      break if computer.output == EXPECTED_OUTPUT
    end
    computer.load(program, 80, 18)
    computer.run
    assert_equal EXPECTED_OUTPUT, computer.output
  end
end

class Computer
  attr_reader :memory, :exit_code

  def initialize
    @memory = []
    @exit_code = 99
  end

  def load(program, value_a = nil, value_b = nil)
    @memory = program.list.dup
    @memory[1] = value_a unless value_a == nil
    @memory[2] = value_b unless value_b == nil
  end

  def run
    position = 0
    until @memory[position] == 99 || @exit_code != 99 do
      if @memory[position] == 1 # addition
        value_a = @memory[@memory[position + 1]]
        value_b = @memory[@memory[position + 2]]
        @memory[@memory[position + 3]] = value_a + value_b
        position += 4
      elsif @memory[position] == 2 # multiplication
        value_a = @memory[@memory[position + 1]]
        value_b = @memory[@memory[position + 2]]
        @memory[@memory[position + 3]] = value_a * value_b
        position += 4
      else
        @exit_code = @memory[position]
      end
    end
  end

  def output
    @memory[0]
  end
end

class Program
  attr_reader :list

  def initialize(list)
    @list = list
  end
end
