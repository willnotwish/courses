module Courses
  module ApplicationHelper

  	include FontAwesome::Rails::IconHelper
  	# def admin_decorate( model, options = {}, &block )
  	# 	decorate( model, options, block )
  	# end

  	# def decorate( model, options = {}, &block )
  	# 	decorated_model = model
  	# 	yield decorated_model if block_given?
  	# 	decorated_model
  	# end

	  DEFAULT_VIEW_TYPE_LABELS = {
	    list:    { text: 'List',            icon: 'list'     },
	    thumbs:  { text: 'Thumbnails',      icon: 'image'    },
	    details: { text: 'Details',         icon: 'list-alt' },
	    gcal:    { text: 'Google Calendar', icon: 'google'   },
	    cal:     { text: 'Native Calendar', icon: 'calendar' }
	  }

	  def view_type_selector( view_type, options={} )
	    types = options[:only] || DEFAULT_VIEW_TYPE_LABELS.keys
	    labels = options[:labels] || DEFAULT_VIEW_TYPE_LABELS
	    content_tag( :ul, nil ) do
	      types.map do |type|
	        html_classes = ['view-type']        
	        html_classes << 'view-type--active' if view_type.to_s == type.to_s
	        content_tag( :li, nil, class: html_classes.join(' ') ) do
	          label = labels[type]
	          link_to vt: {t: type} do
	            (label[:text] + '&nbsp;' + fa_icon( label[:icon] )).html_safe
	          end
	        end
	      end.join( ' ' ).html_safe
	    end
	  end
  end
end
