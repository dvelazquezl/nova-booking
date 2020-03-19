module BookingsHelper
  def room_type(f)
    Room.find(f.object.room_id).room_type.text
  end
  def room_capacity(f)
  Room.find(f.object.room_id).capacity
  end
  def room_type_for(f)
    Room.find(f.room_id).room_type.text
  end
  def room_capacity_for(f)
    Room.find(f.room_id).capacity
  end
end
