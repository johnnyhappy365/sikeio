# == Schema Information
#
# Table name: checkins
#
#  id                   :integer          not null, primary key
#  enrollment_id        :integer
#  problem              :text
#  github_repository    :string
#  time_cost            :integer
#  degree_of_difficulty :integer
#  lesson_id            :integer
#  discourse_post_id    :integer
#  created_at           :datetime
#  updated_at           :datetime
#

class Checkin < ActiveRecord::Base
  belongs_to :enrollment
  belongs_to :lesson

  validates :lesson_id, presence: true

  before_save do
    if self.github_repository.nil?
      self.github_repository = project_repo_url
    end
  end

  after_commit do |checkin|
    PublishTopicJob.perform_later(checkin)
  end

  def self.checkin?(enroll, temp_lesson)
    return false unless (enroll && temp_lesson)
    enroll.checkins.any? do |checkin|
      temp_lesson.id == checkin.lesson_id
    end
  end

  def self.total_number
    all.size
  end

  def self.total_number_of_this_week
    Checkin.where(:created_at => Date.today.beginning_of_week..Date.today).size
  end

  def publish
    discourse_poster.publish
  end

  def published?
    !self.discourse_post_id.nil?
  end

  def github_repository_name
    return nil if github_repository.nil?
    URI.parse(github_repository).path[1..-1]
  end

  def project_repo_url
    return nil if lesson.project.blank?
    # <github-username>/besike-<course-name>-<project-name>
    lesson.project_repo_url_for(enrollment)
  end

  def discourse_poster
    @discourse_poster ||= Checkin::DiscoursePoster.new(self)
  end

  def course
    self.enrollment.course
  end

  def lesson
    Lesson.find self.lesson_id
  end

  def difficulty
    ["太简单", "容易", "适中", "难", "太难"][self.degree_of_difficulty]
  end

  def to_param
    "#{lesson.title}-#{id}".gsub " ","-"
  end
end
