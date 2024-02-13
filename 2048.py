# 运行环境准备
import random


# 打印数组函数
def printmatrix(mat):
    # 将0替换为-，别问，问就是好看
    fmatrix = ["-" if x == 0 else x for x in mat]
    print()
    for i in range(16):
        # 每个数字占四格且靠右对齐，显得美观点
        print(f"{fmatrix[i]:>4}", end=" ")
        # 每四个换行
        if (i + 1) % 4 == 0:
            print()
    print()


# 在空白处随机生成函数
def fillmatrix(mat):
    n = []
    # 查找列表中0的位置并记录在空列表n中
    for i in range(16):
        if mat[i] == 0:
            n.append(i)
    # 生成2或是4
    random_number = random.choice([2, 4])
    # 随机找一个n中的位置，塞数
    random_place = random.choice(n)
    mat[random_place] = random_number


# 测试数列
# testlist = [2,2,0,4]
# 合并函数（1*4矩阵），最重要的子函数
def combinematrix(tlist):
    # 向左合成
    # 算法应该还有优化空间，此处只是给一个比较好理解的算法
    # 原则之一是每一个数只参与合并一次
    # 例如[4,2,0,2]合并后为[4,4,0,0]，不会继续合成[8,0,0,0]
    # 移除数列中所有0
    for i in range(tlist.count(0)):
        tlist.remove(0)
    # tlist = [i for i in tlist if i != 0]
    # 从最左边第一个数开始逐步处理
    j = 0
    # 使用while循环代替for循环，循环控制更加灵活
    # 此处不直接使用常数作为限制条件因为删0后列表长度不确定
    # 列表最后一个数不用判断
    while j < len(tlist) - 1:
        # 寻找是否有相邻的相等的数
        if tlist[j] == tlist[j + 1]:
            # 找到后，将第一个数乘2
            tlist[j] *= 2
            # 将第二个数变为0（被合成了）
            tlist[j + 1] = 0
            # 跳过下一个，直接索引下下个
            j += 2
        else:
            # 否则正常走循环
            j += 1
    # 再次删0
    for i in range(tlist.count(0)):
        tlist.remove(0)
    # 在最后填满0，保持列表长度不变
    while len(tlist) <= 3:
        tlist.append(0)
    return tlist


# 向左移动函数
# 依然有优化空间，此处只是增强可读性
def leftmatrix(tlist):
    new_list = [0] * 16
    sub_list = [tlist[i] for i in [0, 1, 2, 3]]
    combinematrix(sub_list)
    new_list[0] = sub_list[0]
    new_list[1] = sub_list[1]
    new_list[2] = sub_list[2]
    new_list[3] = sub_list[3]
    sub_list = [tlist[i] for i in [4, 5, 6, 7]]
    combinematrix(sub_list)
    new_list[4] = sub_list[0]
    new_list[5] = sub_list[1]
    new_list[6] = sub_list[2]
    new_list[7] = sub_list[3]
    sub_list = [tlist[i] for i in [8, 9, 10, 11]]
    combinematrix(sub_list)
    new_list[8] = sub_list[0]
    new_list[9] = sub_list[1]
    new_list[10] = sub_list[2]
    new_list[11] = sub_list[3]
    sub_list = [tlist[i] for i in [12, 13, 14, 15]]
    combinematrix(sub_list)
    new_list[12] = sub_list[0]
    new_list[13] = sub_list[1]
    new_list[14] = sub_list[2]
    new_list[15] = sub_list[3]
    return new_list


# 向右移动函数
def rightmatrix(tlist):
    new_list = [0] * 16
    sub_list = [tlist[i] for i in [3, 2, 1, 0]]
    combinematrix(sub_list)
    new_list[3] = sub_list[0]
    new_list[2] = sub_list[1]
    new_list[1] = sub_list[2]
    new_list[0] = sub_list[3]
    sub_list = [tlist[i] for i in [7, 6, 5, 4]]
    combinematrix(sub_list)
    new_list[7] = sub_list[0]
    new_list[6] = sub_list[1]
    new_list[5] = sub_list[2]
    new_list[4] = sub_list[3]
    sub_list = [tlist[i] for i in [11, 10, 9, 8]]
    combinematrix(sub_list)
    new_list[11] = sub_list[0]
    new_list[10] = sub_list[1]
    new_list[9] = sub_list[2]
    new_list[8] = sub_list[3]
    sub_list = [tlist[i] for i in [15, 14, 13, 12]]
    combinematrix(sub_list)
    new_list[15] = sub_list[0]
    new_list[14] = sub_list[1]
    new_list[13] = sub_list[2]
    new_list[12] = sub_list[3]
    return new_list


# 向上移动函数
def upmatrix(tlist):
    new_list = [0] * 16
    sub_list = [tlist[i] for i in [0, 4, 8, 12]]
    combinematrix(sub_list)
    new_list[0] = sub_list[0]
    new_list[4] = sub_list[1]
    new_list[8] = sub_list[2]
    new_list[12] = sub_list[3]
    sub_list = [tlist[i] for i in [1, 5, 9, 13]]
    combinematrix(sub_list)
    new_list[1] = sub_list[0]
    new_list[5] = sub_list[1]
    new_list[9] = sub_list[2]
    new_list[13] = sub_list[3]
    sub_list = [tlist[i] for i in [2, 6, 10, 14]]
    combinematrix(sub_list)
    new_list[2] = sub_list[0]
    new_list[6] = sub_list[1]
    new_list[10] = sub_list[2]
    new_list[14] = sub_list[3]
    sub_list = [tlist[i] for i in [3, 7, 11, 15]]
    combinematrix(sub_list)
    new_list[3] = sub_list[0]
    new_list[7] = sub_list[1]
    new_list[11] = sub_list[2]
    new_list[15] = sub_list[3]
    return new_list


# 向下移动函数
def downmatrix(tlist):
    new_list = [0] * 16
    sub_list = [tlist[i] for i in [12, 8, 4, 0]]
    combinematrix(sub_list)
    new_list[12] = sub_list[0]
    new_list[8] = sub_list[1]
    new_list[4] = sub_list[2]
    new_list[0] = sub_list[3]
    sub_list = [tlist[i] for i in [13, 9, 5, 1]]
    combinematrix(sub_list)
    new_list[13] = sub_list[0]
    new_list[9] = sub_list[1]
    new_list[5] = sub_list[2]
    new_list[1] = sub_list[3]
    sub_list = [tlist[i] for i in [14, 10, 6, 2]]
    combinematrix(sub_list)
    new_list[14] = sub_list[0]
    new_list[10] = sub_list[1]
    new_list[6] = sub_list[2]
    new_list[2] = sub_list[3]
    sub_list = [tlist[i] for i in [15, 11, 7, 3]]
    combinematrix(sub_list)
    new_list[15] = sub_list[0]
    new_list[11] = sub_list[1]
    new_list[7] = sub_list[2]
    new_list[3] = sub_list[3]
    return new_list


# 检查游戏状况函数
def checkmatrix(mat):
    # 这里设置当达到8192后通关（最大的四位数），和前文数字对齐方式统一
    if 2**13 in mat:
        printmatrix(mat)
        print("You WIN!")
        exit()
    # 无空白且无法继续移动则失败
    elif (
        (not (0 in mat))
        and matrix == upmatrix(matrix)
        and matrix == leftmatrix(matrix)
        and matrix == downmatrix(matrix)
        and matrix == rightmatrix(matrix)
    ):
        printmatrix(mat)
        print("You LOSE!")
        exit()


# 主程序
# 创建初始列表，由16个0组成
matrix = [0] * 16
# 测试用列表
# matrix = [4, 2, 8, 2, 2, 4, 32, 2, 64, 128, 16, 4, 4, 64, 4, 16]
# 开局两个随机格子
fillmatrix(matrix)
fillmatrix(matrix)

# 人机交互部分
while True:
    checkmatrix(matrix)
    printmatrix(matrix)
    # 输入提示及合法性检查
    while True:
        motion = input(
            "Please enter the movement direction (W/A/S/D).\n"
            "To restart, please enter R. To exit, please enter Q:"
        ).upper()
        if motion in ["W", "A", "S", "D", "R", "Q"]:
            break
        else:
            print()
            printmatrix(matrix)
            print("INPUT ERROR, please try again.\n")
    # 退出程序，在调试的时候极其有用
    if motion == "Q":
        exit()
    # 重启游戏
    elif motion == "R":
        matrix = [0] * 16
        fillmatrix(matrix)
        fillmatrix(matrix)
    # 向上移动，如果矩阵在处理后无变化则直接到最后一个条件，下同
    elif motion == "W" and matrix != upmatrix(matrix):
        matrix = upmatrix(matrix)
        fillmatrix(matrix)
    # 向左移动
    elif motion == "A" and matrix != leftmatrix(matrix):
        matrix = leftmatrix(matrix)
        fillmatrix(matrix)
    # 向下移动
    elif motion == "S" and matrix != downmatrix(matrix):
        matrix = downmatrix(matrix)
        fillmatrix(matrix)
    # 向右移动
    elif motion == "D" and matrix != rightmatrix(matrix):
        matrix = rightmatrix(matrix)
        fillmatrix(matrix)
    # 只剩一种情况：输入的方向无法移动
    else:
        print()
        print("UNABLE TO MOVE, please try again.")

#
