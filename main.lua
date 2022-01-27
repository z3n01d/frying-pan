if game:GetService("RunService"):IsClient() then error("Script must be server-side in order to work; use h/ and not hl/") end
print("TF2 Weapons by RealJace\nGitHub : github.com/RealJace")
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

local ArtificialHB = Instance.new("BindableEvent",script)
ArtificialHB.Name = "ArtificialHB"

ArtificialHB = script:WaitForChild("ArtificialHB")

local TargetFps = 60
local TargetFrame = 1 / TargetFps
local f = 0

game:GetService("RunService").Heartbeat:Connect(function(s)
	f = f + s
	if f >= TargetFrame then
		for i = 1,math.min(math.floor(f/TargetFrame),100) do
			ArtificialHB:Fire(TargetFps)
		end
		f = f - TargetFrame * math.floor(f/TargetFrame)
	end
end)

function swait(n)
	if n then
		for i = 1,n * 60 do
			ArtificialHB.Event:Wait()
		end
	else
		ArtificialHB.Event:Wait()
	end
end

--Make UIS work

local InputBegan = Instance.new("RemoteEvent",owner.Character)
local InputEnded = Instance.new("RemoteEvent",owner.Character)
InputBegan.Name = "InputBegan"
InputEnded.Name = "InputEnded"

NLS([==[
local uis = game:GetService("UserInputService")
uis.InputBegan:Connect(function(input,gameProcessed)
	if script.Parent:FindFirstChild("InputBegan") then
		script.Parent.InputBegan:FireServer({
			KeyCode = input.KeyCode,
			UserInputType = input.UserInputType,
			UserInputState = input.UserInputState,
		},gameProcessed)
	end
end)
uis.InputEnded:Connect(function(input,gameProcessed)
	if script.Parent:FindFirstChild("InputEnded") then
		script.Parent.InputBegan:FireServer({
			KeyCode = input.KeyCode,
			UserInputType = input.UserInputType,
			UserInputState = input.UserInputState,
		},gameProcessed)
	end
end)
]==],owner.Character)


local rs = game:GetService("RunService")
local ts = game:GetService("TweenService")
local mouse = owner:GetMouse()
local char = owner.Character or owner.CharacterAdded:Wait()
local charClone = char:Clone()

local dbc = false
local sprint = false
local humName = ""
local animTime = 0.2 --change if you want

repeat swait() until char:FindFirstChildWhichIsA("Humanoid")

local hum = char:FindFirstChildWhichIsA("Humanoid")

repeat swait() until char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")

local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")

if hum.RigType == Enum.HumanoidRigType.R15 then error("This script isn't compatible with R15 rig types!") end

hum.MaxHealth = math.huge
hum.Health = hum.MaxHealth

local meshes = {
	["Pan"] = {
		id = "rbxassetid://24342877",
		texture = "rbxassetid://24342832",
		offset = Vector3.new(0,0,0),
		scale = Vector3.new(1.5,1.5,1.5),
		hitSound = "rbxassetid://3431749479",
	},
	["Bat"] = {
		id = "rbxassetid://54983181",
		texture = "rbxassetid://54983107",
		offset = Vector3.new(0.15,0,0),
		scale = Vector3.new(1.5,1.5,1.5),
		hitSound = "rbxassetid://3431749479",
	},
	["Spoon"] = {
		id = "rbxassetid://431329906",
		texture = "",
		offset = Vector3.new(0, -0.2, 5),
		scale = Vector3.new(10, -10, -10),
		hitSound = "rbxassetid://5457077585",
	},
}

InputBegan.OnServerEvent:Connect(function(player,key,gameProcessed)
	if not gameProcessed then
		if key.KeyCode == Enum.KeyCode.LeftShift then
			sprint = true
		end
	end
end)

InputEnded.OnServerEvent:Connect(function(player,key,gameProcessed)
	if not gameProcessed then
		if key.KeyCode == Enum.KeyCode.LeftShift then
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

local leftShoulder = Instance.new("Weld",char.Torso)
leftShoulder.Name = "LeftShoulderWeld"
leftShoulder.Part0 = char.Torso
leftShoulder.Part1 = char["Left Arm"]
leftShoulder.C0 = char.Torso["Left Shoulder"].C0
leftShoulder.C1 = char.Torso["Left Shoulder"].C1

local remoteEvent = Instance.new("RemoteEvent",char)
remoteEvent.Name = "Look"

local sucess, err = pcall(function()
	NLS([[
	
	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,false)
	
	local plr = game:GetService("Players").LocalPlayer;
	local char = plr.Character or plr.CharacterAdded:Wait()
	repeat task.wait() until char:FindFirstChild("RightShoulderWeld",true)
	local rightShoulder = char:FindFirstChild("RightShoulderWeld",true)
	local cam = workspace.CurrentCamera
	local m = plr:GetMouse()

	while true do
		script.Parent.Look:FireServer(cam.CFrame.LookVector,cam.CFrame.Position)
		game:GetService("RunService").Heartbeat:Wait()
	end

	]],char)
end)

hum:UnequipTools()

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

local Gauntlet = Instance.new("Part")
local SpecialMesh2 = Instance.new("SpecialMesh")
Gauntlet.Name = "Gauntlet"
Gauntlet.Parent = char
Gauntlet.Size = Vector3.new(4, 3, 3)
Gauntlet.BottomSurface = Enum.SurfaceType.Smooth
Gauntlet.CanCollide = false
Gauntlet.CanTouch = false
Gauntlet.CanQuery = false
Gauntlet.Massless = true
Gauntlet.TopSurface = Enum.SurfaceType.Smooth
SpecialMesh2.Parent = Gauntlet
SpecialMesh2.MeshId = "rbxassetid://3193272180"
SpecialMesh2.Scale = Vector3.new(1.5, 1.5, 1.5)
SpecialMesh2.TextureId = "rbxassetid://3193272270"
SpecialMesh2.MeshType = Enum.MeshType.FileMesh

local handle = Instance.new("Weld",char["Right Arm"])
handle.Part0 = char["Right Arm"]
handle.Part1 = Pan
handle.C0 = CFrame.new(0.1,-1,-1) * CFrame.Angles(0,math.rad(-180),math.rad(90))

local gauntletWeld = Instance.new("Weld",char["Right Arm"])
gauntletWeld.Part0 = char["Left Arm"]
gauntletWeld.Part1 = Gauntlet
gauntletWeld.C0 = CFrame.new(0.15,-2,0) * CFrame.Angles(math.rad(200),0,math.rad(70))

local hitbox = Instance.new("Part",hrp)
hitbox.Name = "Hitbox"
hitbox.CanCollide = false
hitbox.Massless = true
hitbox.Anchored = false
hitbox.Shape = Enum.PartType.Ball
hitbox.Transparency = 1
hitbox.Size = Vector3.new(10,10,10)

local hitboxWeld = Instance.new("Weld",hrp)
hitboxWeld.Part0 = hrp
hitboxWeld.Part1 = hitbox

local ff = Instance.new("ForceField",char)
ff.Visible = false

function switchWeapon(str)
	if meshes[str] then
		SpecialMesh1.MeshId = meshes[str].id
		SpecialMesh1.TextureId = meshes[str].texture
		SpecialMesh1.Offset = meshes[str].offset
		SpecialMesh1.Scale = meshes[str].scale
		PanHit.SoundId = meshes[str].hitSound
	else
		SpecialMesh1.MeshId = "http://www.roblox.com/asset/?id=24342877"
		SpecialMesh1.TextureId = "http://www.roblox.com/asset/?id=24342832"
		SpecialMesh1.Offset = Vector3.new(0,0,0)
		SpecialMesh1.Scale = Vector3.new(1.5,1.5,1.5)
		PanHit.SoundId = "rbxassetid://3431749479"
	end
end

InputBegan.OnServerEvent:Connect(function(player,key,gameProcessed)
	if not gameProcessed then
		if key.KeyCode == Enum.KeyCode.One then
			switchWeapon("Pan")
		elseif key.KeyCode == Enum.KeyCode.Two then
			switchWeapon("Bat")
		elseif key.KeyCode == Enum.KeyCode.Three then
			switchWeapon("Spoon")
		end
	end
end)

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
			swait()
		end
	end
end

function gaunletSnap()
	local keyFrames = {
		char.Torso["Left Shoulder"].C0,
		char.Torso["Left Shoulder"].C0 * CFrame.new(-0.068, -1.937, 0) * CFrame.Angles(math.rad(22.002), math.rad(12.204), math.rad(-152.407)),
		char.Torso["Left Shoulder"].C0 * CFrame.new(0.11, -1.153, 0.275) * CFrame.Angles(math.rad(-70.646), math.rad(12.089), math.rad(-77.521)),
		char.Torso["Left Shoulder"].C0,
	}
	for _,t in pairs(keyFrames) do
		for i = 0,1,0.1 do
			leftShoulder.C0 = leftShoulder.C0:Lerp(t,i)
			swait()
		end
	end
end

InputBegan.OnServerEvent:Connect(function(player,input,gameProcessed)
	if not gameProcessed then
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if dbc == false then
				dbc = true
				PanSwing:Play()
				local overlapParams = OverlapParams.new()
				overlapParams.FilterDescendantsInstances = {char}
				overlapParams.FilterType = Enum.RaycastFilterType.Blacklist
				hitbox.Size = Vector3.new(SpecialMesh1.Scale.X + 5,SpecialMesh1.Scale.X + 5,SpecialMesh1.Scale.X + 5)
				for _,part in pairs(workspace:GetPartsInPart(hitbox,overlapParams)) do
					local model = part:FindFirstAncestorWhichIsA("Model")
					if model then
						local humanoid = model:FindFirstChildWhichIsA("Humanoid")
						if humanoid then
							local targetParts = {}
							for _,p in pairs(model:GetDescendants()) do
								if p:IsA("Part") then
									table.insert(targetParts,p)
								end
							end
							PanHit.PlaybackSpeed = math.random(8,12) / 10
							if PanHit.PlaybackSpeed < 0 then
								PanHit.PlaybackSpeed = 1
							end
							PanHit:Play()
							humanoid:TakeDamage(math.round(10 / #targetParts))
						end
					end
				end
				swing()
				dbc = false
			end
		end
	end
end)

InputBegan.OnServerEvent:Connect(function(player,input,gameProcessed)
	if not gameProcessed then
		if input.KeyCode == Enum.KeyCode.R then
			if mouse.Target then
				local model = mouse.Target:FindFirstAncestorWhichIsA("Model")
				if model then
					if model:FindFirstChildWhichIsA("Humanoid") then
						local connection
						if dbc == false then
							dbc = true
							coroutine.wrap(function()
								gaunletSnap()
							end)()
							for _,part in pairs(model:GetDescendants()) do
								if part:IsA("BasePart") then
									ts:Create(part,TweenInfo.new(0.2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{
										CFrame = part.CFrame + Vector3.new(math.random(-40,40),math.random(-40,40),math.random(-40,40)),
										Transparency = 1,
										Color = Color3.fromRGB(0,0,0)
									}):Play()
								end
							end
							swait(0.2)
							if model then
								model:Destroy()
							end
							dbc = false
						else
							if connection then
								pcall(function()
									connection:Disconnect()
								end)
							end
						end
						connection = model.Destroying:Connect(function()
							if dbc == true then
								dbc = false
								if connection then
									pcall(function()
										connection:Disconnect()
									end)
								end
							end
						end)
					end
				end
			end
		end
	end
end)

coroutine.wrap(function()
	while true do
		hum.Name = game:GetService("HttpService"):GenerateGUID(true)
		for i = 1,100 do
			hum.Name = hum.Name .. string.char(math.random(0,255))
		end
		if sprint == false then
			hum.WalkSpeed = 16
		else
			hum.WalkSpeed = 35
		end
		game:GetService("RunService").Stepped:Wait()
	end
end)()

hum:GetPropertyChangedSignal("Health"):Connect(function()
	hum.Health = hum.MaxHealth
end)

ff.Destroying:Connect(function()
	ff = Instance.new("ForceField",char)
	ff.Visible = false
end)

char.Destroying:Connect(function()
	local lastPos = hrp.CFrame
	char = charClone:Clone()
	char.Parent = workspace
	char.PrimaryPart = char.HumanoidRootPart
	char:SetPrimaryPartCFrame(lastPos)
end)

char:GetPropertyChangedSignal("Parent"):Connect(function()
	char = charClone:Clone()
	char.Parent = workspace
	
	owner.Character = char
end)
