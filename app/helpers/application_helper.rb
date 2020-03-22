module ApplicationHelper
  def current_user?
    admin_signed_in? || customer_signed_in? || sitter_signed_in?
  end

  def current_user
    current_admin || current_customer || current_sitter
  end

  def correct_sign_out_path
    case current_user.class
    when Admin
      :destroy_admin_session_path
    when Customer
      :destroy_customer_session_path
    when
      :destroy_sitter_session_path
    end
  end

  def link_to_add_fields(name, f, association, **args)
    # if f.object.send(association).select{|a| a.start.to_date == args[:day] if a.start.present?}.present?
    #   new_object = f.object.send(association).select{|a| a.start.to_date == args[:day]}.first
    # else
    if association != :kids
      new_object = f.object.send(association).klass.new(start: "#{Date.tomorrow} 10", end: "#{Date.tomorrow} 18")
    else
      new_object = f.object.send(association).klass.new
    end
    # end
    id = new_object.object_id
    fields = f.simple_fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize, f: builder)
    end
    link_to(name, '#', class: "add_fields " + args[:class], data: {id: id, fields: fields.gsub("\n", "")})
  end

  def random_hand
    ['hand-print-green.png', 'hand-print-red.png', 'hand-print-yellow.png'].sample
  end
end
