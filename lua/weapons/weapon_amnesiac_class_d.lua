AddCSLuaFile()
SWEP.myclass = "weapon_amnesiac_class_d"
SWEP.classamenstic = "D" 
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = false
SWEP.ViewModelFOV = 60
SWEP.UseHands = true

SWEP.Slot = 5
SWEP.SlotPos = 2

SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false 

SWEP.Spawnable = true
SWEP.AdminSpawnable = false
SWEP.Category = "VechnLY | Amnestics"
SWEP.Author = "VechniyRabotnik / LONER"

SWEP.ViewModel = "models/weapons/darky_m/c_syringe_v2.mdl"
SWEP.WorldModel = "models/weapons/darky_m/w_syringe_v2.mdl"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "Syringes"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.HoldType = "slam"

function SWEP:Initialize()
    self:SetWeaponHoldType(self.HoldType)

    local lang = AmnesticConfig.Language or "en"
    local translations = AmnesticConfig.LanguageTexts[lang] or {}
    self.PrintName = translations["ClassD"] or "Amnestic | Class: D"
end

function SWEP:Deploy()
    self:SendWeaponAnim(ACT_VM_DRAW)
    self.ReadyAfterDeployAnimation = CurTime()+2.5
    return true
end

function SWEP:Holster()
    return true
end

function SWEP:SecondaryAttack()

end

function SWEP:PrimaryAttack()
    local Owner = self:GetOwner()
    local Traced = self:CheckTrace()
    local restrictedJobs = AmnesticConfig.RestrictedJobs or {}
    if IsValid(Traced) and Traced:IsPlayer() and not Traced:GetNWBool("amnestic_activated", false) and not restrictedJobs[Traced:Team()] then
        self:SetNextPrimaryFire(CurTime()+3)
        Owner:DoAnimationEvent(ACT_GMOD_GESTURE_MELEE_SHOVE_1HAND)
        if CLIENT then return end
        AmnesticsEffectLY(Owner, Traced, self.classamenstic)
        self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
        timer.Simple(3,function()
            if not IsValid(self) or not IsValid(self.Owner) then return end
            if self.Owner:GetActiveWeapon():GetClass() == self.myclass then
                self:SendWeaponAnim(ACT_VM_IDLE)
            end
            self:TakePrimaryAmmo(1)
            if self:Ammo1() <= 0 then
                Owner:StripWeapon(self.myclass)
            end
        end)
    end
end

function SWEP:CheckTrace()
    local Owner = self:GetOwner()
    Owner:LagCompensation(true)
    local Trace = util.TraceLine({
        start = Owner:GetShootPos(),
        endpos = Owner:GetShootPos() + Owner:GetAimVector() * 64,
        filter = Owner
    })
    Owner:LagCompensation(false)
    return Trace.Entity
end

