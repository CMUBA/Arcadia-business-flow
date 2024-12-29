
# Admin Dashboard
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

Email 注册，同时获得 account 地址
购买积分
发行优惠券
已发行优惠券 list
核销优惠券


### 玩家管理后台

积分余额
已兑换 Coupon
点击 coupon，显示二维码和 passcode

## Tech Stack

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
