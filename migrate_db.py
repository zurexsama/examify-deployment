#!/usr/bin/env python3
"""
Database migration script for Examify
Add missing columns and tables to existing database
"""

from app import app, db

def migrate_database():
    """Add missing columns and tables to existing database"""
    with app.app_context():
        try:
            # Add missing columns to quizzes table
            print("Adding missing columns to quizzes table...")
            db.session.execute(db.text("ALTER TABLE quizzes ADD COLUMN IF NOT EXISTS code_expires_at TIMESTAMP NULL"))
            db.session.execute(db.text("ALTER TABLE quizzes ADD COLUMN IF NOT EXISTS max_attempts INT DEFAULT 1"))
            db.session.execute(db.text("ALTER TABLE quizzes ADD COLUMN IF NOT EXISTS allow_concurrent BOOLEAN DEFAULT FALSE"))
            print("Columns added to quizzes table successfully!")

            # Create access_codes table if not exists
            print("Creating access_codes table...")
            db.session.execute(db.text("""
                CREATE TABLE IF NOT EXISTS access_codes (
                    id SERIAL PRIMARY KEY,
                    quiz_id INT,
                    code VARCHAR(8) UNIQUE,
                    is_used BOOLEAN DEFAULT FALSE,
                    used_by INT NULL,
                    used_at TIMESTAMP NULL,
                    FOREIGN KEY (quiz_id) REFERENCES quizzes(id),
                    FOREIGN KEY (used_by) REFERENCES users(id)
                )
            """))
            print("access_codes table created successfully!")

            db.session.commit()
            print("Migration completed successfully!")

        except Exception as e:
            db.session.rollback()
            print(f"Error during migration: {e}")
            print("Make sure PostgreSQL is running and the database exists")

if __name__ == "__main__":
    migrate_database()