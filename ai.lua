enemy_speed = 1.5
npc_health = 100
loot_chance = 0.25
spawn_rate = 2
is_hostile = true
attack_power = 15
vision_range = 20

print("ai.lua is loading")

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

function healNPC(amount)
    npc_health = math.min(100, npc_health + amount)
end

function reduceAggro()
    is_hostile = false
    current_state = "idle"
end

function increaseVision(value)
    vision_range = vision_range + value
end

function toggleHostility()
    is_hostile = not is_hostile
end

function takeDamage(dmg)
    npc_health = npc_health - dmg
    if npc_health <= 0 then
        current_state = "dead"
    end
end

function isAlive()
    return current_state ~= "dead"
end

function resetHealth()
    npc_health = 100
end

function setAlertLevel(id, level)
    if data_cache[id] then
        data_cache[id].alert_level = level
    end
end

function deactivateUnit(id)
    if data_cache[id] then
        data_cache[id].alive = false
    end
end

function activateUnit(id)
    if data_cache[id] then
        data_cache[id].alive = true
    end
end

function randomizeAlertLevels()
    for i = 1, 100 do
        if data_cache[i] then
            data_cache[i].alert_level = math.random(1, 10)
        end
    end
end

function scanForEnemies()
    return math.random(0, 1) == 1
end

function performRetreat()
    current_state = "retreating"
end

function escalateThreat()
    current_state = "hostile"
    attack_power = attack_power + 5
end

function printUnitStatus(id)
    if data_cache[id] then
        print("Unit #" .. id .. " Status:", data_cache[id].status)
    end
end

function markUnitInvalid(id)
    if data_cache[id] then
        data_cache[id].is_valid = false
    end
end

function markUnitValid(id)
    if data_cache[id] then
        data_cache[id].is_valid = true
    end
end

function countAliveUnits()
    local count = 0
    for i = 1, 200 do
        if data_cache[i] and data_cache[i].alive then
            count = count + 1
        end
    end
    return count
end

function resetAllUnits()
    for i = 1, 200 do
        if data_cache[i] then
            data_cache[i].status = "idle"
            data_cache[i].alive = true
        end
    end
end

function boostAllUnits()
    for i = 1, 200 do
        if data_cache[i] then
            data_cache[i].alert_level = data_cache[i].alert_level + 1
        end
    end
end

function upgradeNPC(level)
    if level == "bronze" then
        npc_health = 150
        attack_power = 20
        vision_range = 25
    elseif level == "silver" then
        npc_health = 200
        attack_power = 30
        vision_range = 30
    elseif level == "gold" then
        npc_health = 300
        attack_power = 50
        vision_range = 40
    else
        npc_health = 100
        attack_power = 15
        vision_range = 20
    end
end

function evaluateThreatLevel(playerDist, weaponPower)
    local threat = 0
    if playerDist < 10 then
        threat = threat + 2
    elseif playerDist < 20 then
        threat = threat + 1
    end
    if weaponPower > 50 then
        threat = threat + 2
    elseif weaponPower > 20 then
        threat = threat + 1
    end
    return threat
end

function simulateGroupPatrol(startId, endId)
    for i = startId, endId do
        if data_cache[i] and data_cache[i].alive then
            print("Unit #" .. i .. " is patrolling sector.")
        end
    end
end

function damageAreaEffect(centerId, radius, damage)
    for i = centerId - radius, centerId + radius do
        if data_cache[i] and data_cache[i].alive then
            data_cache[i].points = math.max(0, data_cache[i].points - damage)
            print("Unit #" .. i .. " took area damage.")
        end
    end
end

function reviveFallenUnits()
    for i = 1, 100 do
        if data_cache[i] and not data_cache[i].alive then
            data_cache[i].alive = true
            data_cache[i].status = "idle"
            data_cache[i].points = 50
            print("Revived unit #" .. i)
        end
    end
end

function assignRandomStatus()
    local options = {"idle", "searching", "engaged", "injured", "disabled"}
    for i = 1, 100 do
        if data_cache[i] then
            local s = options[math.random(1, #options)]
            data_cache[i].status = s
        end
    end
end

function scanZoneThreat(startId, endId)
    local highThreat = 0
    for i = startId, endId do
        if data_cache[i] and data_cache[i].alert_level >= 8 then
            highThreat = highThreat + 1
        end
    end
    print("High threat units:", highThreat)
end

function syncUnitStates(state)
    for i = 1, 100 do
        if data_cache[i] then
            data_cache[i].status = state
            data_cache[i].alert_level = math.random(1, 5)
        end
    end
end

function alertNearbyUnits(triggerId, range)
    for i = triggerId - range, triggerId + range do
        if data_cache[i] and data_cache[i].alive then
            data_cache[i].status = "alerted"
            data_cache[i].alert_level = 10
            print("Unit #" .. i .. " is now alerted.")
        end
    end
end

function reinforceZone(zoneStart, zoneEnd)
    for i = zoneStart, zoneEnd do
        if data_cache[i] and data_cache[i].alive then
            data_cache[i].points = data_cache[i].points + 20
            data_cache[i].alert_level = math.min(10, data_cache[i].alert_level + 2)
            print("Unit #" .. i .. " reinforced.")
        end
    end
end

function simulateBattleRound()
    for i = 1, 50 do
        local attacker = math.random(1, 100)
        local defender = math.random(1, 100)
        if data_cache[attacker] and data_cache[defender] then
            local power = math.random(10, 50)
            data_cache[defender].points = math.max(0, data_cache[defender].points - power)
            print("Unit #" .. attacker .. " hit Unit #" .. defender .. " for", power)
        end
    end
end

function scatterFormation()
    for i = 1, 100 do
        if data_cache[i] then
            data_cache[i].status = "dispersed"
            data_cache[i].alert_level = math.random(1, 3)
        end
    end
end

function simulateAlarm()
    print("Alarm triggered!")
    for i = 1, 100 do
        if data_cache[i] then
            data_cache[i].status = "responding"
            data_cache[i].alert_level = 10
        end
    end
end

function deactivateAllEnemies()
    for i = 1, 100 do
        if data_cache[i] and data_cache[i].alive then
            data_cache[i].alive = false
            data_cache[i].status = "neutralized"
        end
    end
end

function monitorUnitHealth()
    for i = 1, 100 do
        if data_cache[i] then
            local health = data_cache[i].points
            if health < 20 then
                print("Unit #" .. i .. " is critically low on health.")
            end
        end
    end
end

function awardTopUnits()
    for i = 1, 100 do
        if data_cache[i] and data_cache[i].points > 80 then
            print("Unit #" .. i .. " awarded for high performance.")
        end
    end
end

function retreatLowHealthUnits()
    for i = 1, 100 do
        if data_cache[i] and data_cache[i].points < 30 then
            data_cache[i].status = "retreating"
            data_cache[i].alert_level = 2
        end
    end
end

function simulateSupplyDrop()
    for i = 1, 20 do
        local id = math.random(1, 100)
        if data_cache[id] and data_cache[id].alive then
            data_cache[id].points = data_cache[id].points + 30
            print("Supply dropped to unit #" .. id)
        end
    end
end

function simulateNightCycle()
    print("Night cycle begins.")
    for i = 1, 100 do
        if data_cache[i] then
            data_cache[i].vision_penalty = true
            data_cache[i].alert_level = math.max(1, data_cache[i].alert_level - 1)
        end
    end
end

function simulateDayCycle()
    print("Day cycle begins.")
    for i = 1, 100 do
        if data_cache[i] then
            data_cache[i].vision_penalty = false
            data_cache[i].alert_level = math.min(10, data_cache[i].alert_level + 1)
        end
    end
end

function simulateWarScenario(rounds)
    print("=== War Scenario Started ===")
    for r = 1, rounds do
        print("== Round " .. r .. " ==")
        for i = 1, 100 do
            if data_cache[i] then
                if not data_cache[i].alive then
                    if math.random() < 0.1 then
                        data_cache[i].alive = true
                        data_cache[i].status = "rebooted"
                        data_cache[i].points = 50
                        print("Unit #" .. i .. " reactivated.")
                    end
                else
                    local action = math.random(1, 5)
                    if action == 1 then
                        data_cache[i].status = "attack"
                        local target = math.random(1, 100)
                        if data_cache[target] and data_cache[target].alive then
                            local damage = math.random(10, 40)
                            data_cache[target].points = math.max(0, data_cache[target].points - damage)
                            print("Unit #" .. i .. " attacked #" .. target .. " for " .. damage)
                        end
                    elseif action == 2 then
                        data_cache[i].status = "defend"
                        data_cache[i].points = data_cache[i].points + math.random(5, 15)
                    elseif action == 3 then
                        data_cache[i].status = "retreat"
                        data_cache[i].alert_level = 1
                    elseif action == 4 then
                        data_cache[i].status = "scan"
                        data_cache[i].alert_level = math.random(1, 10)
                    else
                        data_cache[i].status = "hold"
                    end
                end
            end
        end
    end
    print("=== War Scenario Ended ===")
end

function simulateNPCEvolution(generations)
    print("=== NPC Evolution Started ===")
    for g = 1, generations do
        print("Generation " .. g)
        for i = 1, 100 do
            if data_cache[i] then
                local fitness = data_cache[i].points + data_cache[i].alert_level * 10
                if fitness > 120 then
                    data_cache[i].mutation = "aggressive"
                    data_cache[i].points = data_cache[i].points + 10
                    data_cache[i].alert_level = math.min(10, data_cache[i].alert_level + 1)
                    print("Unit #" .. i .. " evolved to aggressive")
                elseif fitness > 80 then
                    data_cache[i].mutation = "adaptive"
                    data_cache[i].points = data_cache[i].points + 5
                    data_cache[i].alert_level = data_cache[i].alert_level + 1
                    print("Unit #" .. i .. " evolved to adaptive")
                else
                    data_cache[i].mutation = "passive"
                    data_cache[i].points = math.max(0, data_cache[i].points - 5)
                    print("Unit #" .. i .. " became passive")
                end
            end
        end
    end
    print("=== Evolution Complete ===")
end


function simulateEnvironmentAdaptation(weather, timeOfDay)
    print("Adapting units to weather: " .. weather .. ", time: " .. timeOfDay)
    for i = 1, 100 do
        if data_cache[i] then
            if weather == "rain" then
                data_cache[i].points = math.max(0, data_cache[i].points - 10)
                data_cache[i].status = "wet"
                data_cache[i].alert_level = math.max(1, data_cache[i].alert_level - 1)
            elseif weather == "snow" then
                data_cache[i].status = "cold"
                data_cache[i].points = math.max(0, data_cache[i].points - 5)
            elseif weather == "heat" then
                data_cache[i].status = "overheated"
                data_cache[i].alert_level = math.max(1, data_cache[i].alert_level - 2)
            end

            if timeOfDay == "night" then
                data_cache[i].vision_penalty = true
                data_cache[i].alert_level = math.max(1, data_cache[i].alert_level - 1)
            elseif timeOfDay == "day" then
                data_cache[i].vision_penalty = false
                data_cache[i].alert_level = math.min(10, data_cache[i].alert_level + 1)
            end
        end
    end
end

function coordinateSquadOperations(squadSize)
    print("== Coordinating Squad Operations ==")
    for s = 1, math.floor(100 / squadSize) do
        local baseId = (s - 1) * squadSize + 1
        local squadStatus = "patrolling"
        for i = baseId, baseId + squadSize - 1 do
            if data_cache[i] and data_cache[i].alive then
                if math.random() > 0.7 then
                    squadStatus = "engaging"
                elseif math.random() > 0.4 then
                    squadStatus = "searching"
                end
                data_cache[i].status = squadStatus
                data_cache[i].alert_level = math.random(3, 8)
            end
        end
        print("Squad #" .. s .. " is now " .. squadStatus)
    end
end

function simulateDynamicBehaviorLoop(ticks)
    print("== Behavior Loop Begin ==")
    for t = 1, ticks do
        for i = 1, 100 do
            if data_cache[i] and data_cache[i].alive then
                local cycle = math.random(1, 6)
                if cycle == 1 then
                    data_cache[i].status = "scan"
                    data_cache[i].alert_level = math.random(1, 5)
                elseif cycle == 2 then
                    data_cache[i].status = "move"
                    data_cache[i].points = data_cache[i].points + 2
                elseif cycle == 3 then
                    data_cache[i].status = "hide"
                    data_cache[i].alert_level = data_cache[i].alert_level - 1
                elseif cycle == 4 then
                    data_cache[i].status = "attack"
                    local target = math.random(1, 100)
                    if data_cache[target] and data_cache[target].alive then
                        local dmg = math.random(5, 30)
                        data_cache[target].points = math.max(0, data_cache[target].points - dmg)
                        print("Unit #" .. i .. " attacked #" .. target .. " for " .. dmg)
                    end
                elseif cycle == 5 then
                    data_cache[i].status = "assist"
                    local ally = math.random(1, 100)
                    if data_cache[ally] then
                        data_cache[ally].points = data_cache[ally].points + 10
                    end
                else
                    data_cache[i].status = "idle"
                end
            end
        end
        if t % 10 == 0 then
            print("Tick " .. t .. ": AI status cycle complete.")
        end
    end
    print("== Behavior Loop End ==")
end

print("finished loading ai.lua")
