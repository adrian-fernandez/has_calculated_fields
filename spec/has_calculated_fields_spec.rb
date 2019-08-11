require "spec_helper"
require "byebug"

describe HasCalculatedFields do
  describe "runs before_save callbacks" do
    let(:name) { "name" }
    let(:created_at) { Time.find_zone("Madrid").parse("2019-05-03 2pm") }
    let(:obj) { create(:sample_model, created_at: created_at, name: name) }

    context "using time" do
      context "when attribute has value" do
        it "assigns formatted time attribute" do
          new_date = Time.find_zone("Madrid").parse("2019-05-04 4pm")

          obj.created_at = new_date
          expect { obj.save }.to change { obj.calculated_created_at }
            .from("Fri, 03 May 2019 14:00:00 +0200")
            .to("Sat, 04 May 2019 16:00:00 +0200")
        end
      end

      context "when attribute hasn't value" do
        let(:created_at) { nil }
        it "assigns formatted time attribute" do
          expect { obj.save }.to change { obj.calculated_created_at }
            .from(I18n.l(Time.current))
            .to(I18n.l(Time.current.in_time_zone("UTC")))
        end
      end
    end

    context "using method" do
      it "assigns new value to the calculated attribute" do
        obj.name = "new name"

        expect { obj.save }.to change { obj.calculated_name }
          .from("name calculated!")
          .to("new name calculated!")
      end
    end
  end
end
