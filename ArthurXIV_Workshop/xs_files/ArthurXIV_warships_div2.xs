rule chat_warships
active
{
    xsChatData("Warships' hp is divided by 2 on this map.");
    xsDisableSelf();
}

rule damage
active
{
    xsEffectAmount(cMulAttribute,cWarshipClass,cHitpoints,.5);
    xsDisableSelf();
}