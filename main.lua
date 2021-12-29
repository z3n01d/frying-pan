if game:GetService("RunService"):IsClient() then error("Script must be server-side in order to work; use h/ and not hl/") end
local Player,game,owner = owner,game
local RealPlayer = Player
do
	local RealPlayer = RealPlayer
	script.Parent = RealPlayer.Character

	--Fake event to make stuff like Mouse.KeyDown work
	local Disconnect_Function = function(this)
		this[1].Functions[this[2]] = nil
	end
	local Disconnect_Metatable = {__index={disconnect=Disconnect_Function,Disconnect=Disconnect_Function}}
	local FakeEvent_Metatable = {__index={
		Connect = function(this,f)
			local i = tostring(math.random(0,10000))
			while this.Functions[i] do
				i = tostring(math.random(0,10000))
			end
			this.Functions[i] = f
			return setmetatable({this,i},Disconnect_Metatable)
		end
	}}
	FakeEvent_Metatable.__index.connect = FakeEvent_Metatable.__index.Connect
	local function fakeEvent()
		return setmetatable({Functions={}},FakeEvent_Metatable)
	end

	--Creating fake input objects with fake variables
	local FakeMouse = {Hit=CFrame.new(),KeyUp=fakeEvent(),KeyDown=fakeEvent(),Button1Up=fakeEvent(),Button1Down=fakeEvent(),Button2Up=fakeEvent(),Button2Down=fakeEvent()}
	FakeMouse.keyUp = FakeMouse.KeyUp
	FakeMouse.keyDown = FakeMouse.KeyDown
	local UIS = {InputBegan=fakeEvent(),InputEnded=fakeEvent()}
	local CAS = {Actions={},BindAction=function(self,name,fun,touch,...)
		CAS.Actions[name] = fun and {Name=name,Function=fun,Keys={...}} or nil
	end}
	--Merged 2 functions into one by checking amount of arguments
	CAS.UnbindAction = CAS.BindAction

	--This function will trigger the events that have been :Connect()'ed
	local function TriggerEvent(self,ev,...)
		for _,f in pairs(self[ev].Functions) do
			f(...)
		end
	end
	FakeMouse.TriggerEvent = TriggerEvent
	UIS.TriggerEvent = TriggerEvent

	--Client communication
	local Event = Instance.new("RemoteEvent")
	Event.Name = "UserInput_Event"
	Event.OnServerEvent:Connect(function(plr,io)
		if plr~=RealPlayer then return end
		FakeMouse.Target = io.Target
		FakeMouse.Hit = io.Hit
		if not io.isMouse then
			local b = io.UserInputState == Enum.UserInputState.Begin
			if io.UserInputType == Enum.UserInputType.MouseButton1 then
				return FakeMouse:TriggerEvent(b and "Button1Down" or "Button1Up")
			end
			if io.UserInputType == Enum.UserInputType.MouseButton2 then
				return FakeMouse:TriggerEvent(b and "Button2Down" or "Button2Up")
			end
			for _,t in pairs(CAS.Actions) do
				for _,k in pairs(t.Keys) do
					if k==io.KeyCode then
						t.Function(t.Name,io.UserInputState,io)
					end
				end
			end
			FakeMouse:TriggerEvent(b and "KeyDown" or "KeyUp",io.KeyCode.Name:lower())
			UIS:TriggerEvent(b and "InputBegan" or "InputEnded",io,false)
		end
	end)
	Event.Parent = NLS([==[local Event = script:WaitForChild("UserInput_Event")
	local Mouse = owner:GetMouse()
	local UIS = game:GetService("UserInputService")
	local input = function(io,RobloxHandled)
		if RobloxHandled then return end
		--Since InputObject is a client-side instance, we create and pass table instead
		Event:FireServer({KeyCode=io.KeyCode,UserInputType=io.UserInputType,UserInputState=io.UserInputState,Hit=Mouse.Hit,Target=Mouse.Target})
	end
	UIS.InputBegan:Connect(input)
	UIS.InputEnded:Connect(input)

	local h,t
	--Give the server mouse data every second frame, but only if the values changed
	--If player is not moving their mouse, client won't fire events
	local HB = game:GetService("RunService").Heartbeat
	while true do
		if h~=Mouse.Hit or t~=Mouse.Target then
			h,t=Mouse.Hit,Mouse.Target
			Event:FireServer({isMouse=true,Target=t,Hit=h})
		end
		--Wait 2 frames
		for i=1,2 do
			HB:Wait()
		end
	end]==],script)

	----Sandboxed game object that allows the usage of client-side methods and services
	--Real game object
	local RealGame = game

	--Metatable for fake service
	local FakeService_Metatable = {
		__index = function(self,k)
			local s = rawget(self,"_RealService")
			if s then
				return typeof(s[k])=="function"
					and function(_,...)return s[k](s,...)end or s[k]
			end
		end,
		__newindex = function(self,k,v)
			local s = rawget(self,"_RealService")
			if s then s[k]=v end
		end
	}
	local function FakeService(t,RealService)
		t._RealService = typeof(RealService)=="string" and RealGame:GetService(RealService) or RealService
		return setmetatable(t,FakeService_Metatable)
	end

	--Fake game object
	local FakeGame = {
		GetService = function(self,s)
			return rawget(self,s) or RealGame:GetService(s)
		end,
		Players = FakeService({
			LocalPlayer = FakeService({GetMouse=function(self)return FakeMouse end},Player)
		},"Players"),
		UserInputService = FakeService(UIS,"UserInputService"),
		ContextActionService = FakeService(CAS,"ContextActionService"),
		RunService = FakeService({
			_btrs = {},
			RenderStepped = RealGame:GetService("RunService").Heartbeat,
			BindToRenderStep = function(self,name,_,fun)
				self._btrs[name] = self.Heartbeat:Connect(fun)
			end,
			UnbindFromRenderStep = function(self,name)
				self._btrs[name]:Disconnect()
			end,
		},"RunService")
	}
	rawset(FakeGame.Players,"localPlayer",FakeGame.Players.LocalPlayer)
	FakeGame.service = FakeGame.GetService
	FakeService(FakeGame,game)
	--Changing owner to fake player object to support owner:GetMouse()
	game,owner = FakeGame,FakeGame.Players.LocalPlayer
end


--Make UIS work

local InputBegan = Instance.new("BindableEvent",script)
local InputEnded = Instance.new("BindableEvent",script)
InputBegan.Name = "InputBegan"
InputEnded.Name = "InputEnded"

NLS([==[
local uis = game:GetService("UserInputService")
uis.InputBegan:Connect(function(input,gameProcessed)
	if script.Parent:FindFirstChild("InputBegan") then
		script.Parent.InputBegan:Fire(input,gameProcessed)
	end
end)
uis.InputEnded:Connect(function(input,gameProcessed)
	if script.Parent:FindFirstChild("InputEnded") then
		script.Parent.InputEnded:Fire(input,gameProcessed)
	end
end)
]==],script)


local rs = game:GetService("RunService")
local ts = game:GetService("TweenService")
local mouse = owner:GetMouse()
local char = owner.Character or owner.CharacterAdded:Wait()

local dbc = false
local sprint = false
local animTime = 0.2 --change if you want

repeat task.wait() until char:FindFirstChildWhichIsA("Humanoid")

local hum = char:FindFirstChildWhichIsA("Humanoid")

repeat task.wait() until char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")

local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")

if hum.RigType == Enum.HumanoidRigType.R15 then error("This script isn't compatible with R15 rig types!") end

InputBegan.Event:Connect(function(input,gameProcessed)
	if not gameProcessed then
		if input.KeyCode == Enum.KeyCode.LeftShift then
			sprint = true
		end
	end
end)

InputEnded.Event:Connect(function(input,gameProcessed)
	if not gameProcessed then
		if input.KeyCode == Enum.KeyCode.LeftShift then
			sprint = false
		end
	end
end)

local rightShoulder = Instance.new("Weld",char.Torso)
rightShoulder.Name = "RightShoulderWeld"
rightShoulder.Part0 = char.Torso
rightShoulder.Part1 = char["Right Arm"]
rightShoulder.C0 = char.Torso["Right Shoulder"].C0 * CFrame.new(0.551, -1.004, -0.373) * CFrame.Angles(math.rad(22.002), math.rad(-12.204), math.rad(152.407))
rightShoulder.C1 = char.Torso["Right Shoulder"].C1

local remoteEvent = Instance.new("RemoteEvent",char)
remoteEvent.Name = "Look"

local sucess, err = pcall(function()
	NLS([[

	local plr = game:GetService("Players").LocalPlayer;
	local char = plr.Character or plr.CharacterAdded:Wait()
	repeat task.wait() until char:FindFirstChild("RightShoulderWeld",true)
	local rightShoulder = char:FindFirstChild("RightShoulderWeld",true)
	local cam = workspace.CurrentCamera
	local m = plr:GetMouse()
	
	pcall(function()
		for _,i in pairs(char:GetDescendants()) do
			if i:IsA("BasePart") then
				if i.Name == "Right Arm" or i.Name == "Left Arm" or i.Name == "Handle" then
					i.LocalTransparencyModifier = 0
					i:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function()
						i.LocalTransparencyModifier = 0
					end)
				end
			end
		end
	end)

	while true do
		script.Parent.Look:FireServer(cam.CFrame.LookVector,cam.CFrame.Position)
		game:GetService("RunService").Heartbeat:Wait()
	end

	]],char)
end)

if not sucess then
	warn(err)
end

remoteEvent.OnServerEvent:Connect(function(player, origin, hit)
	local char = player.Character
	if char:FindFirstChild("Torso") and char:FindFirstChild("Right Arm") and char:FindFirstChild("Left Arm") and char:FindFirstChild("Right Leg") and char:FindFirstChild("Left Leg") then
		char.Torso["Right Shoulder"].C0 = char.Torso["Right Shoulder"].C0:Lerp(CFrame.new(1,0.5,0) * CFrame.Angles(math.asin((origin).unit.y),1.55,0),0.3)
		char.Torso["Left Shoulder"].C0 = char.Torso["Left Shoulder"].C0:Lerp(CFrame.new(-1,0.5,0) * CFrame.Angles(math.asin((origin).unit.y),-1.55,0),0.3)
		char.Torso["Neck"].C0 = char.Torso["Neck"].C0:Lerp(CFrame.new(0,1,0) * CFrame.Angles(math.asin((origin).unit.y) + 1.55,3.15,0),0.3)
	end
	if dbc == false then
		rightShoulder.C0 = char.Torso["Right Shoulder"].C0 * CFrame.new(0.551, -1.004, -0.373) * CFrame.Angles(math.rad(22.002), math.rad(-12.204), math.rad(152.407))
	end
end)

local Pan = Instance.new("Part")
local PanHit = Instance.new("Sound",Pan)
local PanSwing = Instance.new("Sound",Pan)
--local PitchThing = Instance.new("PitchShiftSoundEffect",PanHit)
local SpecialMesh1 = Instance.new("SpecialMesh")
Pan.Name = "Handle"
Pan.Parent = char
Pan.Color = Color3.new(0.388235, 0.372549, 0.384314)
Pan.Size = Vector3.new(1, 2, 3)
Pan.BottomSurface = Enum.SurfaceType.Smooth
Pan.BrickColor = BrickColor.new("Dark stone grey")
Pan.CanCollide = false
Pan.Massless = true
Pan.Anchored = false
Pan.CanTouch = false
Pan.CanQuery = false
Pan.Reflectance = 0.40000000596046
Pan.TopSurface = Enum.SurfaceType.Smooth
Pan.brickColor = BrickColor.new("Dark stone grey")
Pan.FormFactor = Enum.FormFactor.Plate
Pan.formFactor = Enum.FormFactor.Plate
SpecialMesh1.Parent = Pan
SpecialMesh1.MeshId = "http://www.roblox.com/asset/?id=24342877"
SpecialMesh1.Scale = Vector3.new(2, 2, 2)
SpecialMesh1.TextureId = "http://www.roblox.com/asset/?id=24342832"
SpecialMesh1.MeshType = Enum.MeshType.FileMesh
--PitchThing.Octave = 1
PanHit.SoundId = "rbxassetid://3431749479"
PanHit.Volume = 1
PanSwing.SoundId = "rbxassetid://7122602098"
PanSwing.Volume = 1

local handle = Instance.new("Weld",char["Right Arm"])
handle.Part0 = char["Right Arm"]
handle.Part1 = Pan
handle.C0 = CFrame.new(0.1,-1,-1) * CFrame.Angles(0,math.rad(-180),math.rad(90))

function swing()
	local keyFrames = {
		CFrame.new(-0.301, 0.426, -0.132) * CFrame.Angles(math.rad(22.002), math.rad(-12.204), math.rad(-147.594)),
		CFrame.new(0.149, -0.003, -0.2) * CFrame.Angles(math.rad(-12.49), math.rad(-4.297), math.rad(74.771)),
		CFrame.new(0.128, 0.275, -0.117) * CFrame.Angles(math.rad(52.884), math.rad(21.028), math.rad(24.809)),
		CFrame.new(0.44, 0.03, -0.05) * CFrame.Angles(math.rad(22.002), math.rad(-12.204), math.rad(99.867)),
		CFrame.new(0.551, -1.004, -0.373) * CFrame.Angles(math.rad(22.002), math.rad(-12.204), math.rad(152.407)),
	}
	for _,t in pairs(keyFrames) do
		for i = 0,1,0.15 do
			rightShoulder.C0 = rightShoulder.C0:Lerp(char.Torso["Right Shoulder"].C0 * t,i)
			task.wait()
		end
	end
end

mouse.Button1Down:Connect(function()
	if dbc == false then
		dbc = true
		PanSwing:Play()
		for _,p in pairs(workspace:GetDescendants()) do
			if p:IsA("Model") then
				if p ~= char and p:FindFirstChildWhichIsA("Humanoid") then
					local targethrp = p:FindFirstChild("HumanoidRootPart",true) or p:FindFirstChild("Torso",true) or p:FindFirstChild("Head",true)
					if targethrp then
						local dist = (targethrp.Position - hrp.Position).Magnitude
						if dist < 4 then
							local humanoid = p:FindFirstChildWhichIsA("Humanoid")
							PanHit.PlaybackSpeed = math.random(9,12) / 10
							if PanHit.PlaybackSpeed < 0 then
								PanHit.PlaybackSpeed = 1
							end
							PanHit:Play()
							humanoid.Health -= 10
						end
					end
				end
			end
		end
		swing()
		dbc = false
	end
end)

coroutine.wrap(function()
	while task.wait() do
		if sprint == false then
			hum.WalkSpeed = game.StarterPlayer.CharacterWalkSpeed
		else
			hum.WalkSpeed = 25
		end
	end
end)()