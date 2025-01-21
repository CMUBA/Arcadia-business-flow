# Building based on a framework is harder than building with AI from zero for me, so stop this project. 😿
# ArcadiaAdmin Dashboard

1. Support business flow
2. Support web page and mobile page access
3. Support basic auth

## 流程描述

a basic business flow in initial arcadia version

1. 玩家玩游戏获得积分，可以在游戏外购买，或者叫兑换 coupon。
2. 玩家有了 coupon 优惠券之后。在个人账户的资产下面会显示已经兑换的这个 coupon。
3. coupon 的基本信息：
   1. 发行商家
   2. 优惠券的名称
   3. 优惠券的描述
   4. 优惠券的类型
   5. 优惠券的折扣
   6. 优惠券的过期时间
4. coupon 本身是有状态的：未使用、已使用、已过期。
5. 用户（玩家）登录自己的账户显示出未使用优惠券。点击显示二维码和这个 pass code。
6. 然后玩家到店铺出示这个商家看，商家可以扫描也可以手工输入这个 Pass code 在他登录的商家管理后台。
7. 这就完成了一次 coupon 的使用。
8. 那对于商家来说，他是的二个重要角色。
9. 商家登陆网站点击商家注册。用 EMAIL 注册账户。
10. 有两个主要功能第 1 个，发行优惠券。发行的时候要选择发行的类别和购买的数量。要初始化 coupon 的基本信息
11. 还有一个是核销优惠券。需要输入 pass code 或者二维码扫描。然后核销这个优惠券。
12. 发行和核销优惠券现在是由中心化的核销服务商提供。未来在去中心化。

## 系统设计

### 商家管理后台

#### 注册和登陆

  首页 Email 注册，（同时获得 account 地址，todo）
  验证 email code，或者直接 email 内容链接跳转登陆

#### 商家介绍  

  商家名称、商家介绍、商家位置、商家图片集合
  可以修改，至少三张图片
  提供基于地图的位置

#### 积分充值

  目前仅仅支持现金购买线下交易
  线下管理员/运营人员收到现金，提供充值码
  商家输入充值码，完成积分购买

#### 发行优惠券页面

  自动填写优惠券发行商家
  选择优惠券类型
  选择优惠券折扣等信息（依赖不同优惠券类型）
  选择优惠券发行数量
  选择优惠券开始和过期时间
  选择优惠券发行价格（以积分计算）
  提交，检查商家积分余额，支付积分，提交成功
  
#### 已发行优惠券展示页面

  展示已发行优惠券列表
  展示优惠券状态：未使用、已使用、已过期
  展示优惠券使用情况（百分比）
  展示优惠券过期时间
  展示优惠券折扣
  展示优惠券发行商家
  展示优惠券发行数量
  展示优惠券开始和过期时间
  展示优惠券发行价格（以积分计算）

#### 核销优惠券页面

  前提：（优惠券发行后，玩家积分兑换获得优惠券）
  商家获得玩家提供的凭证，页面输入 passcode 或者二维码扫描
  点击核销优惠券
  核销后，优惠券状态变为已使用

### 玩家管理后台
不提供注册登陆，未来和其他系统集成
展示积分余额（虚假功能）
已兑换 Coupon
点击 coupon，显示二维码和 passcode
显示商家介绍：位置、商家名称、商家介绍，图片集合


## 技术设计
-- 商家表
CREATE TABLE merchants (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  location JSONB,
  images TEXT[], -- 存储图片 URL 数组
  points INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 优惠券类型表
CREATE TABLE coupon_types (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT
);

-- 优惠券表
CREATE TABLE coupons (
  id SERIAL PRIMARY KEY,
  merchant_id INTEGER REFERENCES merchants(id),
  type_id INTEGER REFERENCES coupon_types(id),
  name VARCHAR(255) NOT NULL,
  description TEXT,
  discount_value DECIMAL,
  total_quantity INTEGER NOT NULL,
  remaining_quantity INTEGER NOT NULL,
  points_price INTEGER NOT NULL,
  start_date TIMESTAMP NOT NULL,
  end_date TIMESTAMP NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 玩家优惠券表
CREATE TABLE player_coupons (
  id SERIAL PRIMARY KEY,
  coupon_id INTEGER REFERENCES coupons(id),
  player_id VARCHAR(255) NOT NULL, -- 外部玩家 ID
  pass_code VARCHAR(255) UNIQUE NOT NULL,
  qr_code TEXT, -- 存储二维码 URL
  status VARCHAR(20) DEFAULT 'unused', -- unused, used, expired
  used_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 充值码表
CREATE TABLE recharge_codes (
  id SERIAL PRIMARY KEY,
  code VARCHAR(255) UNIQUE NOT NULL,
  points INTEGER NOT NULL,
  merchant_id INTEGER REFERENCES merchants(id),
  status VARCHAR(20) DEFAULT 'unused', -- unused, used
  used_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


npm install @prisma/client @auth/prisma-adapter qrcode uuid


npx prisma init
npx prisma db push

npx Prisma init

✔ Your Prisma schema was created at prisma/schema.prisma
  You can now open it in your favorite editor.

warn You already have a .gitignore file. Don't forget to add `.env` in it to not commit any private information.

Next steps:
1. Set the DATABASE_URL in the .env file to point to your existing database. If your database has no tables yet, read https://pris.ly/d/getting-started
2. Set the provider of the datasource block in schema.prisma to match your database: postgresql, mysql, sqlite, sqlserver, mongodb or cockroachdb.
3. Run prisma db pull to turn your database schema into a Prisma schema.
4. Run prisma generate to generate the Prisma Client. You can then start querying your database.
5. Tip: Explore how you can extend the ORM with scalable connection pooling, global caching, and real-time database events. Read: https://pris.ly/cli/beyond-orm

More information in our documentation:
https://pris.ly/d/getting-started

# 创建数据库迁移
npx prisma migrate dev --name init

# 生成 Prisma Client
npx prisma generate
Applying migration `20241229045051_init`

The following migration(s) have been created and applied from new schema changes:

migrations/
  └─ 20241229045051_init/
    └─ migration.sql


Resend
import { Resend } from 'resend';

const resend = new Resend('API_KEY');

resend.emails.send({
  from: 'onboarding@resend.dev',
  to: 'jhfnetboy@gmail.com',
  subject: 'Hello World',
  html: '<p>Congrats on sending your <strong>first email</strong>!</p>'
});    

## Tech Stack

https://github.com/Kiranism/react-shadcn-dashboard-starter

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://user-images.githubusercontent.com/9113740/201498864-2a900c64-d88f-4ed4-b5cf-770bcb57e1f5.png">
  <source media="(prefers-color-scheme: light)" srcset="https://user-images.githubusercontent.com/9113740/201498152-b171abb8-9225-487a-821c-6ff49ee48579.png">
</picture>

<div align="center"><strong>Next.js Admin Dashboard Starter Template With Shadcn-ui</strong></div>
<div align="center">Built with the Next.js App Router</div>
<br />
<div align="center">
<a href="https://next-shadcn-dashboard-starter.vercel.app">View Demo</a>
<span>
</div>

## Overview

This is a starter template using the following stack:

- Framework - [Next.js (14 | 15) ](https://nextjs.org/13)
- Language - [TypeScript](https://www.typescriptlang.org)
- Styling - [Tailwind CSS](https://tailwindcss.com)
- Components - [Shadcn-ui](https://ui.shadcn.com)
- Schema Validations - [Zod](https://zod.dev)
- State Management - [Zustand](https://zustand-demo.pmnd.rs)
- Search params state manager - [Nuqs](https://nuqs.47ng.com/)
- Auth - [Auth.js](https://authjs.dev/)
- Tables - [Tanstack Tables](https://ui.shadcn.com/docs/components/data-table)
- Forms - [React Hook Form](https://ui.shadcn.com/docs/components/form)
- Command+k interface - [kbar](https://kbar.vercel.app/)
- Linting - [ESLint](https://eslint.org)
- Pre-commit Hooks - [Husky](https://typicode.github.io/husky/)
- Formatting - [Prettier](https://prettier.io)

_If you are looking for a React admin dashboard starter, here is the [repo](https://github.com/Kiranism/react-shadcn-dashboard-starter)._

## Pages

| Pages                                                                                   | Specifications                                                                                                                      |
| :-------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------- |
| [Signup](https://next-shadcn-dashboard-starter.vercel.app/)                             | Authentication with **NextAuth** supports Social logins and email logins (Enter dummy email for demo).                              |
| [Dashboard](https://next-shadcn-dashboard-starter.vercel.app/dashboard)                 | Cards with recharts graphs for analytics.                                                                                           |
| [Employee](https://next-shadcn-dashboard-starter.vercel.app/dashboard/employee)         | Tanstack tables with server side searching, filter, pagination by Nuqs which is a Type-safe search params state manager in nextjs). |
| [Employee/new](https://next-shadcn-dashboard-starter.vercel.app/dashboard/employee/new) | A Employee Form with shadcn form (react-hook-form + zod).                                                                           |
| [Product](https://next-shadcn-dashboard-starter.vercel.app/dashboard/product)           | Tanstack tables with server side searching, filter, pagination by Nuqs which is a Type-safe search params state manager in nextjs   |
| [Product/new](https://next-shadcn-dashboard-starter.vercel.app/dashboard/product/new)   | A Product Form with shadcn form (react-hook-form + zod).                                                                            |
| [Profile](https://next-shadcn-dashboard-starter.vercel.app/dashboard/profile)           | Mutistep dynamic forms using react-hook-form and zod for form validation.                                                           |
| [Kanban Board](https://next-shadcn-dashboard-starter.vercel.app/dashboard/kanban)       | A Drag n Drop task management board with dnd-kit and zustand to persist state locally.                                              |
| [Not Found](https://next-shadcn-dashboard-starter.vercel.app/dashboard/notfound)        | Not Found Page Added in the root level                                                                                              |
| -                                                                                       | -                                                                                                                                   |

## Getting Started

Follow these steps to clone the repository and start the development server:

> [!NOTE]  
> If you want to use the starter with  **Next 15** with **React 19**, follow these steps:
> - Clone only the `next-15` branch:
>   ```bash
>   git clone --branch next-15 --single-branch https://github.com/Kiranism/next-shadcn-dashboard-starter.git

- Clone the repo:
```bash 
git clone https://github.com/Kiranism/next-shadcn-dashboard-starter.git 
```

- `npm install`
- Create a `.env.local` file by copying the example environment file:
  `cp env.example.txt .env.local`
- Add the required environment variables to the `.env.local` file.
- `npm run dev`

You should now be able to access the application at http://localhost:3000.

> [!WARNING]  
> After cloning or forking the repository, be cautious when pulling or syncing with the latest changes, as this may result in breaking conflicts.

Cheers! 🥂
