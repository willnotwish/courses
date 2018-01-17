# application_operation.rb

module Courses
	class ApplicationOperation
		include ActiveModel::Model
		include ActiveModel::Validations
		include ActiveModel::Validations::Callbacks
	end
end