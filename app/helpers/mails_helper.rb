module MailsHelper
	def status_translate report
		if report.pending?
			"Ожидается"
		elsif report.done? and report.report_file.blank?
			"Ответ без файла"
		else
			"Выполнен"
		end
	end
end
