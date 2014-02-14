class Session < ActiveRecord::Base
 	has_many :trials, dependent: :destroy
	include FriendlyId
  	friendly_id :random_id

  def my_results(speedaccuracy, style, color)
		groupdata = []
		title = nil
		labels = nil

		if speedaccuracy == 'speed'
			title = "Speed"

			if style == 'both' && color == 'both'
				labels = ["Solid Black","Hollow Black","Solid White","Hollow White"]
				groupdata = [
					((self.trials.where("style = ? AND color = ?", 'solid', 'white_bg').average('task_time').to_f / 1000).round(3)),
					((self.trials.where("style = ? AND color = ?", 'hollow', 'white_bg').average('task_time').to_f / 1000).round(3)),
					((self.trials.where("style = ? AND color = ?", 'solid', 'black_bg').average('task_time').to_f / 1000).round(3)),
					((self.trials.where("style = ? AND color = ?", 'hollow', 'black_bg').average('task_time').to_f / 1000).round(3))
				]

			elsif style == 'either' && color == 'either'
				labels = ["All"]
				groupdata = [(self.trials.average('task_time').to_f / 1000).round(3)]
			
			elsif style == 'both' && color == 'either'
				labels = ["Solid", "Hollow"]				
				groupdata = [
					((self.trials.where(style: 'solid').average('task_time').to_f / 1000).round(3)),
					((self.trials.where(style: 'hollow').average('task_time').to_f / 1000).round(3))
				]

			elsif style == 'either' && color == 'both'
				labels = ["Black on White", "White on Black"]	
				groupdata = [
					((self.trials.where(color: 'white_bg').average('task_time').to_f / 1000).round(3)),
					((self.trials.where(color: 'black_bg').average('task_time').to_f / 1000).round(3))
				]
			end

		elsif speedaccuracy == 'accuracy'
			title = "Accuracy"
			
			if style == 'both' && color == 'both'
				labels = ["Solid Black","Hollow Black","Solid White","Hollow White"]
				groupdata = [
					((self.trials.where("style = ? AND color = ? AND task_success = ?", 'solid', 'white_bg', true).count.to_f / 0.06).round(1)),
					((self.trials.where("style = ? AND color = ? AND task_success = ?", 'hollow', 'white_bg', true).count.to_f / 0.06).round(1)),
					((self.trials.where("style = ? AND color = ? AND task_success = ?", 'solid', 'black_bg', true).count.to_f / 0.06).round(1)),
					((self.trials.where("style = ? AND color = ? AND task_success = ?", 'hollow', 'black_bg', true).count.to_f / 0.06).round(1))
				]

			elsif style == 'either' && color == 'either'
				labels = ["All"]
				groupdata = [(self.trials.where(task_success: true).count.to_f / 0.24).round(1)]
			
			elsif style == 'both' && color == 'either'
				labels = ["Solid", "Hollow"]				
				groupdata = [
					((self.trials.where("style = ? AND task_success = ?", 'solid', true).count.to_f / 0.12).round(1)),
					((self.trials.where("style = ? AND task_success = ?", 'hollow', true).count.to_f / 0.12).round(1))
				]

			elsif style == 'either' && color == 'both'
				labels = ["Black on White", "White on Black"]
				groupdata = [
					((self.trials.where("color = ? AND task_success = ?", 'white_bg', true).count.to_f / 0.12).round(1)),
					((self.trials.where("color = ? AND task_success = ?", 'black_bg', true).count.to_f / 0.12).round(1))
				]
			end
		end
		groupdata << labels << title
		return groupdata
	end

end
