FactoryGirl.define do

  factory :maze do
    string <<-'string'.gsub(/^ {6}/, "")
      #####################################
      # #   #     #A        #     #       #
      # # # # # # ####### # ### # ####### #
      # # #   # #         #     # #       #
      # ##### # ################# # #######
      #     # #       #   #     # #   #   #
      ##### ##### ### ### # ### # # # # # #
      #   #     #   # #   #  B# # # #   # #
      # # ##### ##### # # ### # # ####### #
      # #     # #   # # #   # # # #       #
      # ### ### # # # # ##### # # # ##### #
      #   #       #   #       #     #     #
      #####################################
    string
    initialize_with { new(string) }
  end

end
