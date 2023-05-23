state("popcapgame1", "Steam")
{
    int foodBank : "popcapgame1.exe", 0x1AC624, 0xB4, 0x38;
    int stage : "popcapgame1.exe", 0x1AC624, 0x3C, 0x28;
    sbyte normalModeStage : "popcapgame1.exe", 0x1AC624, 0xB4, 0x48;
    sbyte timeAttackModeStage : "popcapgame1.exe", 0x1AC624, 0xB4, 0x68;
    bool isMenu : "popcapgame1.exe", 0x1AC624, 0x28, 0xE4;
    bool isStageMap : "popcapgame1.exe", 0x1AC624, 0x84, 0xE4;
    string40 stageLoading : "popcapgame1.exe", 0x1AC624, 0x84, 0x10C, 0x50, 0x9C, 0x0;
}

state("FeedingFrenzy2", "Other")
{
    int foodBank : "FeedingFrenzy2.exe", 0x1AC624, 0xB4, 0x38;
    int stage : "FeedingFrenzy2.exe", 0x1AC624, 0x3C, 0x28;
    sbyte normalModeStage : "FeedingFrenzy2.exe", 0x1AC624, 0xB4, 0x48;
    sbyte timeAttackModeStage : "FeedingFrenzy2.exe", 0x1AC624, 0xB4, 0x68;
    bool isMenu : "FeedingFrenzy2.exe", 0x1AC624, 0x28, 0xE4;
    bool isStageMap : "FeedingFrenzy2.exe", 0x1AC624, 0x84, 0xE4;
    string40 stageLoading : "FeedingFrenzy2.exe", 0x1AC624, 0x84, 0x10C, 0x50, 0x9C, 0x0;
}

startup
{
    settings.Add("SingleStage", false, "Single Stage Split");
}

init
{
    if (modules.First().ModuleMemorySize > 1949000)
    {
        version = "Steam"; // 1949696
    }

    else
    {
        version = "Other";
    }
}

start
{
    if (current.isStageMap)
    {
        return ((current.normalModeStage != -1 || current.timeAttackModeStage != -1) && !current.stageLoading.Contains("Click"));
    }
}

split
{
    // Stage Split
    if (current.stageLoading != old.stageLoading)
    {
        return true;
    }

    // Any% End
    if (current.stageLoading.Contains("60"))
    {
        return (current.foodBank > old.foodBank);
    }

    // Single Stage End
    if (settings["SingleStage"])
    {
        return (current.stage > old.stage);
    }
}

reset
{
    if (current.isMenu)
    {
        return true;
    }
}
