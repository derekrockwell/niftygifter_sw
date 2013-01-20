module DeviseHelper
	def devise_error_messages!

		if(defined? resource)
			return "" if resource.errors.empty?

			messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
			sentence = I18n.t("errors.messages.not_saved",
				:count => resource.errors.count,
				:resource => resource.class.model_name.human.downcase)

			html = <<-HTML
			<div id="error_explanation">
				<h2>#{sentence}</h2>
				<ul>#{messages}</ul>
			</div>
			HTML

			html.html_safe
		else
			""
		end
	end
end

module ApplicationHelper
	def link_to_add_fields(name, f, association)
		new_object = f.object.send(association).klass.new
		id = new_object.object_id
		fields = f.fields_for(association, new_object, child_index: id) do |builder|
			render(association.to_s.singularize + "_fields", f: builder)
		end
		link_to(name, '#', class: "add_fields btn", data: {id: id, fields: fields.gsub("\n", "")})

	end
end

