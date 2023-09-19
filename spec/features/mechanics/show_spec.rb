require "rails_helper"

RSpec.describe "mechanic show page" do
  describe "when I visit a mechanic show page" do
    it "then I see their name, years of experience, and the names of all rides they are working on." do
      amusement_park1 = create(:amusement_park)
      
      mechanic1 = create(:mechanic)
      mechanic2 = create(:mechanic)
      mechanic3 = create(:mechanic)
      mechanic4 = create(:mechanic)

      ride1 = create(:ride)
      ride2 = create(:ride)

      RideMechanic.create!(ride_id: ride1.id, mechanic_id: mechanic2.id)
      RideMechanic.create!(ride_id: ride2.id, mechanic_id: mechanic4.id)

      visit mechanic_path(mechanic2)

      within("#mechanic-show-#{mechanic2.id}") do
        expect(page).to have_content(mechanic2.name)
        expect(page).to have_content(mechanic2.years_experience)
        expect(page).to have_content(ride1.name)
      end

      visit mechanic_path(mechanic4)

      within("#mechanic-show-#{mechanic4.id}") do
        expect(page).to have_content(mechanic4.name)
        expect(page).to have_content(mechanic4.years_experience)
        expect(page).to have_content(ride2.name)
      end
    end

    it "then I see a form to add a ride to their workload & when I fill in that field with an id of an existing ride and click Submit, I’m taken back to that mechanic's show page and I see the name of that newly added ride on this mechanic's show page." do
      amusement_park1 = create(:amusement_park)
      
      mechanic1 = create(:mechanic)
      mechanic2 = create(:mechanic)
      mechanic3 = create(:mechanic)
      mechanic4 = create(:mechanic)

      ride1 = create(:ride)
      ride2 = create(:ride)

      RideMechanic.create!(ride_id: ride1.id, mechanic_id: mechanic2.id)
      RideMechanic.create!(ride_id: ride2.id, mechanic_id: mechanic4.id)

      visit mechanic_path(mechanic2)

      fill_in 'Ride ID', with: ride2
      click_button 'Submit'

      within("#mechanic-show-#{mechanic2.id}") do
        expect(current_path).to eq(mechanic_path(mechanic2))
        expect(page).to have_content(mechanic2.name)
        expect(page).to have_content(mechanic2.years_experience)
        expect(page).to have_content(ride1.name)
        expect(page).to have_content(ride2.name)
      end

      visit mechanic_path(mechanic4)

      fill_in 'Ride ID', with: ride1
      click_button 'Submit'

      within("#mechanic-show-#{mechanic4.id}") do
        expect(current_path).to eq(mechanic_path(mechanic4))
        expect(page).to have_content(mechanic4.name)
        expect(page).to have_content(mechanic4.years_experience)
        expect(page).to have_content(ride2.name)
        expect(page).to have_content(ride1.name)
      end
    end
  end
end