module ApplicationHelper
  def current_user?
    admin_signed_in? || customer_signed_in? || sitter_signed_in?
  end

  def current_user
    current_admin || current_customer || current_sitter
  end


  def current_sitter?(sitter)
    current_sitter == sitter
  end

  def current_customer?(customer)
    current_customer == customer
  end

  def current_admin?(admin)
    current_admin == admin
  end


  def current_user_show_path
    case current_user.class
    when Admin
      path = admin_path(current_user)
    when Customer
      path = customer_path(current_user)
    when Sitter
      path = sitter_path(current_user)
    end
    return path
  end

  def link_to_add_fields(name, f, association, **args)
    if association != :kids
      new_object = f.object.send(association).klass.new(starts_at: "#{Date.tomorrow} 10", ends_at: "#{Date.tomorrow} 18")
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
