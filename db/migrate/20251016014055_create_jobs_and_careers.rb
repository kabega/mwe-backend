class CreateJobsAndCareers < ActiveRecord::Migration[8.0]
  def change
    create_table :jobs_and_careers do |t|
      t.string :job_title
      t.string :department
      t.text :job_description
      t.string :job_type
      t.string :level
      t.string :status
      t.string :location
      t.string :salary_range
      t.text :requirements
      t.text :responsibilities
      t.date :application_deadline
      t.string :contact_email

      t.timestamps
    end
  end
end
