<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        /*
         |------------------------------------------------------------
         | Conturi fictive pentru testare (User / Agent / Admin)
         |------------------------------------------------------------
         */

        User::firstOrCreate(
            ['email' => 'employee@helpdeskit.test'],
            [
                'name' => 'Employee User',
                'password' => Hash::make('password'),
            ]
        );

        User::firstOrCreate(
            ['email' => 'agent@helpdeskit.test'],
            [
                'name' => 'Support Agent',
                'password' => Hash::make('password'),
            ]
        );

        User::firstOrCreate(
            ['email' => 'admin@helpdeskit.test'],
            [
                'name' => 'System Administrator',
                'password' => Hash::make('password'),
            ]
        );

        /*
         |------------------------------------------------------------
         | Categorii de bază (ticketing)
         |------------------------------------------------------------
         */
        $this->call([
            CategorySeeder::class,
        ]);
    }
}
