# frozen_string_literal: true

# @api private
class Literal::Types::ArrayType
	def initialize(type)
		@type = type
	end

	def inspect = "_Array(#{@type.inspect})"

	def ===(value)
		Array === value && value.all?(@type)
	end

	def check(value, &blk)
		Literal.check(value, Array, &blk)
		value.each_with_index do |item, index|
			Literal.check(item, @type) do |c|
				blk.call c.nest(+"[" << index.inspect << "]", expected: @type, actual: item)
			end
		end
	end
end
