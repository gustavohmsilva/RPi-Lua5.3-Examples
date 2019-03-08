local sleep = require 'socket'.sleep
local periphery = require 'periphery'
local PWM = require 'pwm'
local GPIO = periphery.GPIO
local GPIO_14 = GPIO(14, 'out')
local GPIO_15 = GPIO(15, 'out')

local inicia_pwm = function(port, freq, pass)
	PWM.Initialize(pass)
	PWM.SetMode(port, 'w')
	PWM.SetGPIOpwmFreq(port, freq)
end

local abre_catraca = function(port, farolVermelho, farolVerde)
	PWM.SetGPIOpulseWidth(port, 500)
	farolVermelho:write(false)
	farolVerde:write(true)
end

local fecha_catraca = function(port, farolVermelho, farolVerde)
	farolVermelho:write(true)
	farolVerde:write(false)
	PWM.SetGPIOpulseWidth(port, 1600)
end

inicia_pwm(18, 50, 'LuaOnMyPi')
abre_catraca(18, GPIO_14, GPIO_15)
local cruzamento_em_funcionamento = true

while cruzamento_em_funcionamento do
	io.write('O trem está chegando? (S/N/FIM)')
	local esta_chegando = io.read()
	if esta_chegando:lower() == 's' then
		fecha_catraca(18, GPIO_14, GPIO_15)
		sleep(3)
		abre_catraca(18, GPIO_14, GPIO_15)
	elseif esta_chegando:lower() == 'fim' then
		os.exit()
	end
end
