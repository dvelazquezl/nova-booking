  module ApplicationHelper
  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  def link_to_add_fields(name, f, association, partial_param)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize , f: builder, partial_param: partial_param)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def get_score_color(range)
    colors = %w(danger warning success)
    case range
    when 0..3
      colors.first
    when 4..8
      colors.second
    else
      colors.third
    end
  end
  def label_score(score)
    label = " "
    if score > 0 && score <= 1
      label = "Pésimo"
    elsif score > 1 && score <= 2
      label = "Malo"
    elsif score > 2 && score <= 3
      label = "Mediocre"
    elsif score > 3 && score <= 4
      label = "Regular"
    elsif score > 4 && score <= 5
      label = "Aceptable"
    elsif score > 5 && score <= 6
      label = "Comodo"
    elsif score > 6 && score <= 7
      label = "Bueno"
    elsif score > 7 && score <= 8
      label = "Muy Bueno"
    elsif score > 8 && score <= 9
      label = "Excelente"
    elsif score > 9 && score <= 10
      label = "Excepcional "
      return label
    end
  end
end
