module GeofencesHelper
  def vertices_to_array(vertices)
    output = []
    vertices.each do |v|
      output << [v.latitude, v.longitude]
    end
    output
  end
end
