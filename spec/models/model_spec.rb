require 'spec_helper'

describe 'Model Examples' do
	it 'should be accessible in RSpec' do
		model = ModelName.new
		model.should be_a_kind_of(ModelName)
	end
end