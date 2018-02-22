module Courses
  class Admin::UserDecorator < ApplicationDecorator

  	delegate :name, to: :object

  	def user_roles
  		Courses::UserRole.for_user( object )
  	end

  	def roles( course = nil )
  		# For this, we need Arel, because the User class has no notion of the user_roles join to courses
  		t1 = Role.arel_table
  		t2 = Courses::UserRole.arel_table

  		j = t1.join( t2, Arel::Nodes::InnerJoin ).on t1[:id].eq(t2[:role_id])

  		Role.joins( j.join_sources ).merge user_roles.for_course( course )
  	end

  	def role_permissions( course = nil )
  		RolePermission.joins( :role ).merge roles( course )
  	end

  	def permissions( course = nil )
  		Permission.joins( :role_permissions ).merge role_permissions( course )
  	end

  	def has_permission_to?( action_name, course = nil )
  		permissions(course).merge( Permission.to( action_name ) ).present?
  	end

  	# def able_to_publish?( course = nil )
  	# 	has_permission_to? :publish, course
  	# end

  	# def able_to_restrict?( course = nil )
  	# 	has_permission_to? :restrict, course
  	# end

  	# def able_to_show?( course = nil )
  	# 	has_permission_to? :show, course
  	# end

    # def able_to_show_all_courses?
    #   able_to_show?( nil )
    # end

    # def able_to_show_all_courses?
    #   able_to_show?( nil )
    # end
  end
end


    # def courses_permitted_to( action_name )
    #   ur_scope = Courses::UserRole.with_permission_to( action_name ).for_user( object )
    #   if ur_scope.where( course: nil ).present?
    #     Courses::Course.all
    #   else  
    #     Courses::Course.joins( :user_roles ).merge ur_scope
    #   end
    # end

    # def accessible_courses
    #   courses_permitted_to :show
    # end

    # def courses_permitted_to_update
    #   courses_permitted_to :update
    # end
