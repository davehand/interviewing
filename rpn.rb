#!/usr/bin/ruby

ZERO_ASCII_CODE = 48 #ascii code for 0, used for number conversion

#converts a string to an integer by utilizing
#the ascii code for 0 and a rolling sum
def atoi(string_int)
  sum = 0
  string_int.each_byte do |char|
    sum = (sum * 10) + (char - ZERO_ASCII_CODE)
  end

  return sum
end

#converts a string to a floating point number by utilizing
#the ascii code for 0, the atoi method, and a rolling sum
def atof(string_float)
  sum = 0
  float_sum = 0
  decimal_split = string_float.split('.')
  if (decimal_split[0] != nil)
    sum = atoi(decimal_split[0])
  end

  if (decimal_split[1] != nil)
    decimal_split[1].each_byte.reverse_each do |char|
      float_sum = (float_sum * 0.1) + ((char - ZERO_ASCII_CODE)*0.1)
    end
  end

  return sum + float_sum
end

#used to check that a valid operation exists,
#i.e. there are two elements for the binary operator
def checkValidOperation(array)
  if array.length < 2
    abort('Not enough arguments to perform an operation. Input string is invalid. Aborting')
  end
end

#get calculation string from command line
#split calculation line and instantiate
#our array - we'll use it as a stack
calc_string = ARGV[0].strip
string_elements = calc_string.split(' ')
number_array = []

#for each element in input string, figure out
#if it is an integer, float, operator, or invalid
#then perform the correct operation:
#Integer or floating point: convert from string
#and then add to stack
#Operator: pop last two elements from the stack
#and then perform the operation on them
#Invalid char: abort program, print out invalid char
string_elements.each do |element|
  if element =~ /\A\d+\z/
    number_array.push atoi(element)
  elsif element =~ /\A\d*\.\d*\z/
    number_array.push atof(element)
  elsif element =~ /\A\+\z/
    checkValidOperation(number_array)
    result = number_array.pop + number_array.pop
    number_array.push result
  elsif element =~ /\A\-\z/
    checkValidOperation(number_array)
    temp = number_array.pop
    result = number_array.pop - temp
    number_array.push result
  elsif element =~ /\A\*\z/
    checkValidOperation(number_array)
    result = number_array.pop * number_array.pop
    number_array.push result
  elsif element =~ /\A\/\z/
    checkValidOperation(number_array)
    temp = number_array.pop
    result = number_array.pop / temp
    number_array.push result
  else
    abort("'#{element}' is not a number or operation. Input string is invalid. Aborting.")
  end
end

#if the only number left in our array is the result
#pop it off and print the result
#otherwise, there are too many elements in the string
#abort, and print the error
if number_array.length == 1
  result = number_array.pop
  puts "The result is: #{result}"
else
  abort("The input string has #{number_array.length-1} extra number(s). Input string is invalid. Aborting")
end

