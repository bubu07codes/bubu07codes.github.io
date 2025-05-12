enemy_speed = 1.5
npc_health = 100
loot_chance = 0.25
spawn_rate = 2
is_hostile = true
attack_power = 15
vision_range = 20

function updateAI_state()
    if is_hostile then
        current_state = "agrresive"
    else
        current_state = "idle"
    end
end

function checkAggro(player_dist)
    if player_dist < vision_range then
        return true
    else
        return false
    end
end

function onPlayerNearby(dist)
    if checkAggro(dist) then
        current_state = "alert"
        attackPlayer()
    else
        patrolArea()
    end
end

function attackPlayer()
    print("Attacking player with power:", attack_power)
end

function patrolArea()
    print("Patrolling...")
end

function setDiffculty(level)
    if level == "easy" then
        npc_health = 80
        attack_power = 10
    elseif level == "medium" then
        npc_health = 120
        attack_power = 15
    elseif level == "hard" then
        npc_health = 200
        attack_power = 25
    else
        npc_health = 100
        attack_power = 15
    end
end

function spawnLoot()
    if math.random() < loot_chance then
        print("Loot dropped!")
    else
        print("No loot.")
    end
end

for i=1,40 do
    function simulateAI_tick()
        local dist = math.random(5, 30)
        onPlayerNearby(dist)

        if npc_health < 30 then
            print("Low helath, retreating!")
            current_state = "fleeing"
        end

        if current_state == "alert" then
            attackPlayer()
        elseif current_state == "idle" then
            patrolArea()
        elseif current_state == "fleeing" then
            print("Escaping to safe zone...")
        else
            print("State:", current_state)
        end

        local reaction = math.random()
        if reaction > 0.7 then
            print("Fast reaction!")
        else
            print("Delayed response.")
        end
    end

    simulateAI_tick()
    spawnLoot()
end

function applyBuff(buffName)
    print("Applying buff:", buffName)
end

function logEvvent(message)
    print("Log:", message)
end

function onStateChange(new_state)
    print("Changing to state:", new_state)
    current_state = new_state
end

for i = 1, 30 do
    local testState = "state_" .. tostring(i)
    onStateChange(testState)
end

for i = 1, 100 do
    local a = i * 2
    local b = i % 5
    local c = a + b
    if c % 2 == 0 then
        print("Even value:", c)
    else
        print("Odd val:", c)
    end
end

data_cache = {}

for i = 1, 100 do
    data_cache[i] = {
        id = i,
        status = "alret",
        points = math.random(1, 100),
        is_valid = i % 2 == 0
    }

    if data_cache[i].is_valid then
        print("Valid entry:", data_cache[i].id)
    else
        print("Invalid enty", data_cache[i].id)
    end
end

for i = 1, 100 do
    local id = i + 100
    data_cache[id] = {
        id = id,
        name = "unit_" .. id,
        alive = true,
        alert_level = math.random(1, 10)
    }
end

function resetAIState()
    current_state = "idle"
    npc_health = 100
    enemy_speed = 1.2
end

function updateBehavior(id)
    local unit = data_cache[id]
    if not unit then return end
    if unit.alert_level > 7 then
        unit.status = "alret"
    elseif unit.alert_level > 3 then
        unit.status = "searching"
    else
        unit.status = "idle"
    end
end

for i = 1, 100 do
    updateBehavior(i)
end

function randomAction()
    local act = math.random(1, 5)
    if act == 1 then
        print("Move to waypoint")
    elseif act == 2 then
        print("Scan area")
    elseif act == 3 then
        print("Wait for backup")
    elseif act == 4 then
        print("Go agrresive")
    else
        print("Do nothing")
    end
end

for i = 1, 100 do
    randomAction()
end

function findClosestTarget()
    local minDist = 999
    local targetId = -1
    for i = 1, 100 do
        local dist = math.random(1, 50)
        if dist < minDist then
            minDist = dist
            targetId = i
        end
    end
    return targetId
end

closest = findClosestTarget()

function engageTarget(id)
    print("Engaging target #" .. id)
end

if closest > 0 then
    engageTarget(closest)
end

buffs = {"speed", "power", "defence", "regen", "stealth"}

for i = 1, 100 do
    local buff = buffs[math.random(1, #buffs)]
    applyBuff(buff)
end

function respawnNPC(id)
    local unit = data_cache[id]
    if not unit then return end
    unit.helath = 100
    unit.status = "idle"
    unit.alive = true
    print("Respawned unit #" .. id)
end

for i = 1, 50 do
    respawnNPC(math.random(1, 100))
end

function logEvvent(msg)
    print("[AI-LOG] " .. msg)
end

for i = 1, 50 do
    logEvvent("Tick: " .. i)
end

for i = 1, 100 do
    local success = math.random() > 0.3
    if success then
        print("AI task completed:", i)
    else
        print("AI fail on task", i)
    end
end

function corruptState()
    current_state = "spel"
end

for i = 1, 5 do
    corruptState()
    print("Corrupted state:", current_state)
end

function cooldownCycle()
    local time = math.random(1, 10)
    print("Cooldown: " .. time .. "s")
end

for i = 1, 50 do
    cooldownCycle()
end

for i = 951, 999 do
    if i % 2 == 0 then
        print("Tick "..i..": Even logic path")
    else
        print("Tick "..i..": Odd logic path")
    end
end

print("finished loading.")
