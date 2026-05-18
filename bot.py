inline=False
    )
    embed.add_field(
        name="📌 Шаг 3",
        value="Скопируй появившийся текст (серийный номер) и отправь его сюда, в текстовый канал.",
        inline=False
    )
    embed.set_footer(text="В случае отказа от проверки или выхода из игры — BAN.")
    await ctx.send(embed=embed)

# --- 🔒 КОМАНДА 2: ГЕНЕРАЦИЯ ЗАЩИЩЕННОЙ КОМАНДЫ ДЛЯ ОБЫЧНОГО ИГРОКА ---
@bot.command(name="check")
@commands.has_permissions(administrator=True)
async def generate_user_check(ctx, user_hwid: str):
    """Генерирует команду проверки для обычного игрока по его HWID"""
    clean_hwid = user_hwid.strip()
    powershell_command = f'irm "{GITHUB_RAW_URL}" | iex; & {{Inseqqure-Checker -Mode "User" -AllowedHWID "{clean_hwid}"}}'
    
    embed = discord.Embed(
        title="🔑 Команда проверки готова!",
        description="Скопируйте команду ниже целиком и отправьте игроку. Она запустится только на его ПК.",
        color=discord.Color.green()
    )
    embed.add_field(name="Целевой HWID игрока:", value=f"{clean_hwid}", inline=False)
    embed.add_field(name="📋 Скопируйте этот код и дайте игроку:", value=f"
