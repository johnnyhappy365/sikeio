
RSpec.describe Lesson, :type => :model do

  before(:each) do
    course = Course.create(name: "lesson test")
    week =  Week.create(title: "week-title")
    course.weeks << week
    week.lessons << Lesson.create(name: "lesson 1")
    @lesson = course.weeks.first.lessons.first
  end

  describe "Lesson name presence" do
    it 'should not create lesson if lesson name is not presence' do
      expect { @lesson.update!(name: nil) }.to raise_error
      
    end
  end

  describe "Lesson name uniq in one course" do
    pending "not implement"

    it 'should create new lesson in one course if lesson name not exists' do

    end

    it 'should fail to create new lesson if lesson name exists' do
      
    end
  end

  describe "Lesson's course presence" do
    it 'should not create lesson if no week to belong' do
      expect { @lesson.update!(week_id: nil) }.to raise_error
    end
    
  end

end
