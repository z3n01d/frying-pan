local owner = game:GetService("Players").LocalPlayer
local rs = game:GetService("RunService")
local ts = game:GetService("TweenService")
local mouse = owner:GetMouse()
local char = owner.Character or owner.CharacterAdded:Wait()

local dbc = false
local animTime = 0.2 --change if you want

repeat task.wait() until char:FindFirstChildWhichIsA("Humanoid")

local hum = char:FindFirstChildWhichIsA("Humanoid")

repeat task.wait() until char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")

local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")

if hum.RigType == Enum.HumanoidRigType.R15 then error("This script isn't compatible with R15 rig types!") end

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
	game:GetService("RunService").RenderStepped:connect(function()
		if char:FindFirstChild("Torso") and char:FindFirstChild("Right Arm") and char:FindFirstChild("Left Arm") and char:FindFirstChild("Right Leg") and char:FindFirstChild("Left Leg") then
			rightShoulder.C0 = rightShoulder.C0:Lerp(CFrame.new(1,0.5,0) * CFrame.Angles(math.asin((cam.CFrame.LookVector).unit.y),1.55,0),0.3)
			char.Torso["Left Shoulder"].C0 = char.Torso["Left Shoulder"].C0:Lerp(CFrame.new(-1,0.5,0) * CFrame.Angles(math.asin((cam.CFrame.LookVector).unit.y),-1.55,0),0.3)
			char.Torso["Neck"].C0 = char.Torso["Neck"].C0:Lerp(CFrame.new(0,1,0) * CFrame.Angles(math.asin((cam.CFrame.LookVector).unit.y) + 1.55,3.15,0),0.3)
		end
	end)

	while task.wait(1) do
		script.Parent.Look:FireServer(cam.CFrame.LookVector,cam.CFrame.Position)
	end

	]],char)
end)

if not sucess then
	warn(err)
end

remoteEvent.OnServerEvent:Connect(function(player, origin, hit)
	local char = player.Character
	if char:FindFirstChild("Torso") and char:FindFirstChild("Right Arm") and char:FindFirstChild("Left Arm") and char:FindFirstChild("Right Leg") and char:FindFirstChild("Left Leg") then
		rightShoulder.C0 = rightShoulder.C0:Lerp(CFrame.new(1,0.5,0) * CFrame.Angles(math.asin((origin).unit.y),1.55,0),0.3)
		char.Torso["Left Shoulder"].C0 = char.Torso["Left Shoulder"].C0:Lerp(CFrame.new(-1,0.5,0) * CFrame.Angles(math.asin((origin).unit.y),-1.55,0),0.3)
		char.Torso["Neck"].C0 = char.Torso["Neck"].C0:Lerp(CFrame.new(0,1,0) * CFrame.Angles(math.asin((origin).unit.y) + 1.55,3.15,0),0.3)
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
		local params = RaycastParams.new()
		params.FilterDescendantsInstances = {char}
		params.FilterType = Enum.RaycastFilterType.Blacklist
		local result = workspace:Raycast(hrp.Position,hrp.Position + (hrp.CFrame.LookVector * 3),params)
		PanSwing:Play()
		if result and result.Instance then
			local model = result.Instance:FindFirstAncestorWhichIsA("Model")
			if model then
				local hum = model:FindFirstChildWhichIsA("Humanoid",true)
				if hum then
					PanHit.PlaybackSpeed = math.random(9,12) / 10
					if PanHit.PlaybackSpeed < 0 then
						PanHit.PlaybackSpeed = 1
					end
					PanHit:Play()
					hum.Health -= 10
				end
			end
		end
		swing()
		dbc = false
	end
end)
