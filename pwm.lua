pwm = {}
	pwm.Initialize = function(sudo_pass)
		os.execute('echo '..sudo_pass..' | sudo -S pigpiod')
	end

	pwm.RawEntry = function(command)
		os.execute(command)
	end

	pwm.SetMode = function(GPIO, mode)
		local command = string.format('pigs m %s %s', GPIO, mode)
		os.execute(command)
	end

	pwm.SetDutyCycle = function(GPIO, DutyCycle)
		local command = string.format('pigs p %s %s', GPIO, DutyCycle)
		os.execute(command)
	end

	pwm.GetDutyCycle = function(GPIO)
		local command = string.format('pigs gdc %s', GPIO)
		r = io.popen(command)
		response = r:read('*a'):gsub('\n','')
                return response
	end

	pwm.SetGPIOpwmRange = function(GPIO, pwmRange)
		local command = string.format('pigs prs %s %s', GPIO, pwmRange)
	end
	
	pwm.GetGPIOpwmRange = function(GPIO)
		local command = string.format('pigs prg %s', GPIO)
		r = io.popen(command)
		response = r:read('*a'):gsub('\n','')
                return response
	end

	pwm.SetGPIOpwmFreq = function(GPIO, Freq)
		local command = string.format('pigs pfs %s %s', GPIO, Freq)
		os.execute(command)
	end
	
	pwm.GetGPIOpwmFreq = function(GPIO)
		local command = string.format('pigs pfg %s', GPIO)
		r = io.popen(command)
		response = r:read('*a'):gsub('\n','')
                return response
	end

	pwm.SetGPIOpulseWidth = function(GPIO, Microseconds)
		local command = string.format('pigs s %s %s', GPIO, Microseconds)
		os.execute(command)
	end

	pwm.GetGPIOpwmRealRange = function(GPIO)
		local command = string.format('pigs prrg %s', GPIO)
		r = io.popen(command)
		response = r:read('*a'):gsub('\n','')
                return response
	end

return pwm
