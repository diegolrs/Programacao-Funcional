defmodule Lasagna do
  #private function
  defp time_to_prepare_layer() do
    2
  end
  def expected_minutes_in_oven() do
    40
  end
  def remaining_minutes_in_oven(time) do
    expected_minutes_in_oven() - time
  end
  def preparation_time_in_minutes(layers_to_prepare) do
    layers_to_prepare * time_to_prepare_layer()
  end
  def total_time_in_minutes(layers_quantity, minutes_on_oven) do
    preparation_time_in_minutes(layers_quantity) + minutes_on_oven
  end
  def alarm() do
    "Ding!"
  end
end
